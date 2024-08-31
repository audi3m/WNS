//
//  AccountManager.swift
//  WNS
//
//  Created by J Oh on 8/14/24.
//

import Foundation

final class AccountManager {
    
    static let shared = AccountManager()
    private init() { }
    
    var access: String {
        get {
            return UserDefaults.standard.string(forKey: "access") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "access")
            print("액세스 토큰 재설정")
        }
    }
    
    var refresh: String {
        get {
            return UserDefaults.standard.string(forKey: "refresh") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "refresh")
            print("리프레시 토큰 재설정")
        }
    }
    
    var userID: String {
        get {
            return UserDefaults.standard.string(forKey: "userID") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userID")
            print("userID")
        }
    }
    
    var isAdmin: Bool {
        userID == "66d1ff39dfc656014225765f"
    }
    
}

extension AccountManager {
    func resetAccount() {
        access = ""
        refresh = ""
        userID = ""
    }
}
