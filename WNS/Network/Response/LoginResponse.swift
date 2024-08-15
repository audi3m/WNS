//
//  LoginResponse.swift
//  WNS
//
//  Created by J Oh on 8/15/24.
//

import Foundation

struct LoginResponse: Decodable {
    let userID: String
    let email: String
    let nick: String
    let profileImage: String?
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email
        case nick
        case profileImage
        case accessToken
        case refreshToken
    }
    
}

