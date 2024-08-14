//
//  TokenManager.swift
//  WNS
//
//  Created by J Oh on 8/14/24.
//

import Foundation

final class TokenManager {
    
    static let shared = TokenManager()
    private init() { }
    
    var access: String {
        get {
            return UserDefaults.standard.string(forKey: "access") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "access")
        }
    }
    
    var refresh: String {
        get {
            return UserDefaults.standard.string(forKey: "refresh") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "refresh")
        }
    }
    
    
}
