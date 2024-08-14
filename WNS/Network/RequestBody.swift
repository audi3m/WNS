//
//  LoginQuery.swift
//  WNS
//
//  Created by J Oh on 8/14/24.
//

import Foundation

protocol asd {
    
}

enum RequestBody {
    case join
    case emailValidation
    case login
    
    
    
    
    case editProfile
}

struct LoginQuery: Encodable {
    let email: String
    let password: String
    let nickname: String
    let phoneNum: String?
    let birthDay: String?
}










