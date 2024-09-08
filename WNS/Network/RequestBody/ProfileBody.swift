//
//  ProfileBody.swift
//  WNS
//
//  Created by J Oh on 8/15/24.
//

import Foundation

struct ProfileBody: Codable {
    var nick: String?
    var phoneNum: String?
    var birthDay: String?
    var profile: Data?
}
