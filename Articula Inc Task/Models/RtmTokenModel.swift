//
//  RtmTokenModel.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 11.04.2023.
//

import Foundation


struct RtmTokenModel : Codable {
    let token, userID, expiration: String

    enum CodingKeys: String, CodingKey {
        case token
        case userID = "user_id"
        case expiration
    }
}
