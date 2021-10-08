//
//  NFCReader.swift
//  MillenniumPass
//
//  Created by krzysp on 08/10/2021.
//

import Foundation
import CoreNFC

private let electronicPassportAID = "A0000002471001"

final class NFCReader: NSObject {

    private var session: NFCTagReaderSession?
    private(set) var tagInfo: TagInfo?

    struct TagInfo {
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

    func startReading() {
        guard NFCReaderSession.readingAvailable else {
//            self.delegate?.idReaderDidDetectTag(idReader: self, result: .failure(.readingUnavailable))
            return
        }

        session = NFCTagReaderSession(pollingOption: .iso14443, delegate: self)
        session?.begin()
    }

    func endReading() {
        invalidateSession(error: .end)
    }

    func connectToTag(_ tag: NFCTag) {
        guard let session = session,
              self.tagInfo == nil
        else { fatalError("No active session!") }

        guard case let .iso7816(iso7816Tag) = tag else {
//            delegate?.idReaderDidDetectTag(idReader: self, result: .failure(.invalidTagType(tag)))
            return
        }

        session.connect(to: tag) { error in
            if error != nil {
//                self.invalidateSession(error: TagReadingError.couldNotConnectToTag(iso7816Tag))
                return
            }

            self.tagInfo = TagInfo(tag: tag)
//            self.delegate?.idReaderDidConnect(to: tag)
        }
    }

    private func invalidateSession(error: TagReadingError? = nil) {
        session?.invalidate(errorMessage: error?.description ?? "")
        session = nil
    }
}

extension NFCReader: NFCTagReaderSessionDelegate {

    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        print("NFCIDReader::tagReaderSessionDidBecomeActive")
    }

    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        print("NFCIDReader::tagReaderSession:session:didInvalidateWithError")

//        delegate?.idReaderDidDetectTag(idReader: self, result: .failure(.sessionInvalidate(error)))
    }

    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        print("NFCIDReader::tagReaderSession:session:didDetect")

        guard tags.count == 1 else {
//            delegate?.idReaderDidDetectTag(idReader: self, result: .failure(.tooManyTagsFound(tags)))
            return
        }
        guard let firstTag = tags.first else {
//            delegate?.idReaderDidDetectTag(idReader: self, result: .failure(.noTagFound))
            return
        }
        guard case let .iso7816(iso7816Tag) = firstTag else {
//            delegate?.idReaderDidDetectTag(idReader: self, result: .failure(.invalidTagType(firstTag)))
            return
        }
        guard iso7816Tag.initialSelectedAID == electronicPassportAID else {
//            delegate?.idReaderDidDetectTag(idReader: self, result: .failure(.invalidAID(iso7816Tag)))
            return
        }

//        delegate?.idReaderDidDetectTag(idReader: self, result: .success(TagInfo(tag: firstTag)))
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
