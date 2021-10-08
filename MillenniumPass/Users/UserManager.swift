//
//  UserManager.swift
//  MillenniumPass
//
//  Created by krzysp on 08/10/2021.
//

import Foundation
import Combine

final class UserManager: ObservableObject {

    static let shared: UserManager = .init()

    @Published
    var user: User?

    @Published
    var isLoggedIn: Bool = false

    init() {
        NFCReader.shared.delegate = self
    }

}

extension UserManager: NFCReaderDelegate {

    func stateChange(_ state: NFCReader.LoggedInState) {
        switch state {
        case .idle:
            isLoggedIn = false
        case .loggedIn:
            isLoggedIn = true
        case .unauthorized:
            isLoggedIn = false
        }
    }
}
