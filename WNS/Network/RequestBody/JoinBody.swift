//
//  JoinBody.swift
//  WNS
//
//  Created by J Oh on 8/14/24.
//

import Foundation

struct JoinBody: Encodable {
    let email: String
    let password: String
    let nickname: String
    let phoneNum: String?
    let birthDay: String?
}










