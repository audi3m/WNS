//
//  FollowResponse.swift
//  WNS
//
//  Created by J Oh on 8/15/24.
//

import Foundation

struct FollowResponse: Decodable {
    let nick: String
    let opponentNick: String
    let followingStatus: Bool
    
    enum CodingKeys: String, CodingKey {
        case nick
        case opponentNick = "opponent_nick"
        case followingStatus = "following_status"
    }
}

struct UnFollowResponse: Decodable {
    let nick: String
    let opponentNick: String
    let followingStatus: Bool
    
    enum CodingKeys: String, CodingKey {
        case nick
        case opponentNick = "opponent_nick"
        case followingStatus = "following_status"
    }
}
