//
//  GetMyProfileResponse.swift
//  WNS
//
//  Created by J Oh on 8/15/24.
//

import Foundation

struct GetMyProfileResponse: Decodable {
    let userID: String
    let email: String
    let nick: String
    let phoneNum: String?
    let birthDay: String?
    let profileImage: String?
    let followers: [Profile]
    let following: [Profile]
    let posts: [String]
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email
        case nick
        case phoneNum
        case birthDay
        case profileImage
        case followers
        case following
        case posts
    }
}

struct Profile: Decodable {
    let userID: String
    let nick: String
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case nick
        case profileImage
    }
}
