//
//  NFCReader.swift
//  MillenniumPass
//
//  Created by krzysp on 08/10/2021.
//

import Foundation
import CoreNFC
import UIKit

private let electronicPassportAID = "A0000002471001"

protocol NFCReaderDelegate: AnyObject {
    func stateChange(_ state: NFCReader.LoggedInState)
}

final class NFCReader: NSObject {

    static let shared: NFCReader = .init()

    private var session: NFCTagReaderSession?
    private var tagInfo: TagInfo?
    weak var delegate: NFCReaderDelegate?
    private(set) var state: LoggedInState = .idle {
        didSet {
            delegate?.stateChange(state)
        }
    }

    private struct TagInfo {
        let tag: NFCTag

        var iso7816Tag: NFCISO7816Tag? {
            switch tag {
                case .iso7816(let tag):
                    return tag
                default:
                    return nil
            }
        }
    }

    enum LoggedInState {
        case idle
        case loggedIn(_ user: User)
        case unauthorized
    }

    enum TagReadingError: Swift.Error {
        case readingUnavailable
        case tooManyTagsFound([NFCTag])
        case noTagFound
        case invalidTagType(NFCTag)
        case invalidAID(NFCISO7816Tag)
        case couldNotConnectToTag(NFCISO7816Tag)
        case sessionInvalidate(Error)
        case end
    }

    enum CommandType {
        case performAuth
        case signIn
        case unauthorized
    }

    func startReading() {
        guard NFCReaderSession.readingAvailable else {
//            self.delegate?.idReaderDidDetectTag(idReader: self, result: .failure(.readingUnavailable))
            return
        }

        session = NFCTagReaderSession(pollingOption: .iso14443, delegate: self)
        session?.begin()
    }

    func endReading() {
        invalidateSession(error: nil)
    }

    private func connectToTag(_ tag: NFCTag) {
        guard let session = session
        else { fatalError("No active session!") }

        session.connect(to: tag) { error in
            if error != nil {
                return
            }

            let userIdentifier = UIDevice.current.identifierForVendor!.uuidString

            self.tagInfo = TagInfo(tag: tag)
            self.sendAuthorization(with: userIdentifier) { state in
                self.state = state ?? .idle
                self.endReading()
            }
        }
    }

    private func sendAuthorization(with userIdentifier: String, completion: @escaping (_ state: LoggedInState?) -> Void) {
        guard let tagInfo = tagInfo,
              let iso7816Tag = tagInfo.iso7816Tag
        else { fatalError("No tag stored!") }

        let command = NFCReader.CommandType.performAuth
        let userIdentifierData = userIdentifier.data(using: .ascii)!
        let apdu = NFCISO7816APDU(instructionClass: command.bytes[0], instructionCode: command.bytes[1], p1Parameter: 0, p2Parameter: 0, data: userIdentifierData, expectedResponseLength: 1)

        print("apdu.data \(apdu.data!.hexEncodedString())")
        session?.alertMessage = "Asking for priviledges…"

        iso7816Tag.sendCommand(apdu: apdu) { (data, p1, p2, error) in
            guard error == nil else { fatalError() }

            if let commandType = data.commandType {
                switch commandType {
                case .performAuth:
                    // should not happen!
                    fatalError()
                    break
                case .signIn:
                    let userId: UInt8? = data.count >= 3 ? data[2] : nil
                    print("userId = \(String(describing: userId))")
                    if let userId = userId, let user = User.fromIdentifier(userId) {
                        print("user = \(user)")
                        completion(.loggedIn(user))
                    } else {
                        completion(.unauthorized)
                    }
                case .unauthorized:
                    completion(.unauthorized)
                }
            }
        }
    }

    private func invalidateSession(error: TagReadingError? = nil) {
        if let error = error {
            session?.invalidate(errorMessage: error.description ?? "")
        } else {
            session?.invalidate()
        }
        session = nil
    }
}

extension NFCReader: NFCTagReaderSessionDelegate {

    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        print("NFCIDReader::tagReaderSessionDidBecomeActive")
    }

    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        print("NFCIDReader::tagReaderSession:session:didInvalidateWithError")
    }

    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        print("NFCIDReader::tagReaderSession:session:didDetect")

        guard tags.count == 1 else {
            return
        }
        guard let firstTag = tags.first else {
            return
        }

        connectToTag(firstTag)
    }
}

fileprivate extension NFCReader.TagReadingError {

    var description: String {
        switch self {
            case .readingUnavailable:
                return "readingUnavailable"
            case .tooManyTagsFound(_):
                return "tooManyTagsFound"
            case .noTagFound:
                return "noTagFound"
            case .invalidTagType(_):
                return "invalidTagType"
            case .invalidAID(_):
                return "invalidAID"
            case .couldNotConnectToTag(_):
                return "couldNotConnectToTag"
            case .sessionInvalidate(_):
                return "sessionInvalidate"
            case .end:
                return "end"
        }
    }
}

fileprivate extension NFCReader.CommandType {

    var bytes: [UInt8] {
        switch self {
        case .performAuth:
            return [0xAA, 0xAA]
        case .signIn:
            return [0xAA, 0xAF]
        case .unauthorized:
            return [0x45, 0x12]
        }
    }
}

func == (left: [UInt8], right: [UInt8]) -> Bool {
    guard left.count == right.count else { return false }

    for i in 0..<min(left.count, right.count) {
        if left[i] != right[i] {
            return false
        }
    }

    return true
}

fileprivate extension Data {

    var commandPair: [UInt8] {
        if count >= 2 {
            return [self[0], self[1]]
        } else {
            return []
        }
    }

    var commandType: NFCReader.CommandType? {
        if commandPair == NFCReader.CommandType.signIn.bytes {
            return NFCReader.CommandType.signIn
        } else if commandPair == NFCReader.CommandType.unauthorized.bytes {
            return NFCReader.CommandType.unauthorized
        } else {
            return nil
        }
    }
}

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let hexDigits = options.contains(.upperCase) ? "0123456789ABCDEF" : "0123456789abcdef"
        if #available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
            let utf8Digits = Array(hexDigits.utf8)
            return String(unsafeUninitializedCapacity: 2 * self.count) { (ptr) -> Int in
                var p = ptr.baseAddress!
                for byte in self {
                    p[0] = utf8Digits[Int(byte / 16)]
                    p[1] = utf8Digits[Int(byte % 16)]
                    p += 2
                }
                return 2 * self.count
            }
        } else {
            let utf16Digits = Array(hexDigits.utf16)
            var chars: [unichar] = []
            chars.reserveCapacity(2 * self.count)
            for byte in self {
                chars.append(utf16Digits[Int(byte / 16)])
                chars.append(utf16Digits[Int(byte % 16)])
            }
            return String(utf16CodeUnits: chars, count: chars.count)
        }
    }
}
