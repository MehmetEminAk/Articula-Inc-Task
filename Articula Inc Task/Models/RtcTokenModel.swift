//
//  RtcTokenFile.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 11.04.2023.
//

import Foundation


struct RtcTokenModel : Codable  {
    var token : String
    var channel : String
    var expirationTime : String
    
    enum CodingKeys : String , CodingKey {
        case token
        case expirationTime = "expiration_time"
        case channel
    }
    
}
