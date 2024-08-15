//
//  ProfileQuery.swift
//  WNS
//
//  Created by J Oh on 8/15/24.
//

import Foundation

struct ProfileQuery: Encodable {
    let nick: String?
    let phoneNum: String?
    let birthDay: String?
    let profile: Data?
}
