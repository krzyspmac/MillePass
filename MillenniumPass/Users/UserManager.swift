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
    var loggedInUser: User?

}
