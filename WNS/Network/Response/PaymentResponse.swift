//
//  PaymentResponse.swift
//  WNS
//
//  Created by J Oh on 9/8/24.
//

import Foundation

struct PaymentResponse: Decodable {
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

struct PaymentListResponse: Decodable {
    let data: [PaymentResponse]
}
