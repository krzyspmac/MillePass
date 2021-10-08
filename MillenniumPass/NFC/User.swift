//
//  User.swift
//  MillenniumPass
//
//  Created by krzysp on 08/10/2021.
//

import Foundation

struct User: Decodable{
    let name: String
    let surname: String
}

extension User{

    static func fromIdentifier(_ id: UInt8) -> User? {
        let filename = "\(id).user.json"

        if let url = Bundle.main.url(forResource: filename, withExtension: nil), let data = try? Data(contentsOf: url) {
            return try? JSONDecoder().decode(User.self, from: data)
        } else {
            return nil
        }
    }
}
