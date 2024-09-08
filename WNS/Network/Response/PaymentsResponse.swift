//
//  PaymentsResponse.swift
//  WNS
//
//  Created by J Oh on 9/8/24.
//

import Foundation

struct PaymentsResponse: Decodable {
    let buyerID: String
    let postID: String
    let merchantUID: String
    let productName: String
    let price: Int
    let paidAt: String
    
    enum CodingKeys: String, CodingKey {
        case buyerID = "buyer_id"
        case postID = "post_id"
        case merchantUID = "merchant_uid"
        case productName
        case price
        case paidAt
    }
    
}

struct PaymentsListResponse: Decodable {
    let data: [PaymentsResponse]
}
