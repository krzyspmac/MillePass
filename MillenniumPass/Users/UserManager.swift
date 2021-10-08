//
//  UserManager.swift
//  MillenniumPass
//
//  Created by krzysp on 08/10/2021.
//

import Foundation

final class UserManager {

    static let shared: UserManager = .init()

    var loggedInUser: User?

}
