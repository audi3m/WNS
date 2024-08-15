//
//  WithdrawResponse.swift
//  WNS
//
//  Created by J Oh on 8/15/24.
//

import Foundation

struct WithdrawResponse: Decodable {
    let userID: String
    let email: String
    let nick: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email
        case nick
    }
}
