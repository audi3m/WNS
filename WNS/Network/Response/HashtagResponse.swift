//
//  HashtagResponse.swift
//  WNS
//
//  Created by J Oh on 8/15/24.
//

import Foundation

struct HashtagResponse: Decodable {
    let data: [PostResponse]
    let nextCursor: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case nextCursor = "next_cursor"
    }
}
