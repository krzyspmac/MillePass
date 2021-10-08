//
//  User.swift
//  MillenniumPass
//
//  Created by krzysp on 08/10/2021.
//

import Foundation
import UIKit

struct User: Decodable{
    let name: String
    let surname: String
    let imageBase64: String
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

extension User {

    var image: UIImage? {
        guard let data = Data(base64Encoded: imageBase64),
              let image = UIImage(data: data)
        else { return nil }
        return image
    }
}
