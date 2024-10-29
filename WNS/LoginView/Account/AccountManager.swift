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
    
    var email: String {
        get {
            return UserDefaults.standard.string(forKey: "email") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "email")
        }
    }
    
    var password: String {
        get {
            return UserDefaults.standard.string(forKey: "password") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "password")
        }
    }
    
    var nick: String {
        get {
            return UserDefaults.standard.string(forKey: "nick") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "nick")
        }
    }
    
    var profileImage: String? {
        get {
            return UserDefaults.standard.string(forKey: "profileImage")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "profileImage")
        }
    }
    
    var followers: [String] {
        get {
            return UserDefaults.standard.stringArray(forKey: "followers") ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "followers")
        }
    }
    
    var following: [String] {
        get {
            return UserDefaults.standard.stringArray(forKey: "following") ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "following")
        }
    }
    
    var access: String {
        get {
            return UserDefaults.standard.string(forKey: "access") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "access")
            print("액세스 토큰 재설정 - \(Date.now.formatted())")
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
        }
    }
    
    var posts: [String] {
        get {
            return UserDefaults.standard.stringArray(forKey: "posts") ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "posts")
        }
    }
    
    var isAdmin: Bool {
        userID == "66d1ff39dfc656014225765f"
    }
    
}

extension AccountManager {
    
    func setMyProfile(with response: GetMyProfileResponse) {
        
        userID = response.userID
        email = response.email
        nick = response.nick
        profileImage = response.profileImage
        followers = response.followers.map { $0.userID }
        following = response.following.map { $0.userID }
        posts = response.posts
    }
    
    func resetAccount() {
        email = ""
        password = ""
        nick = ""
        profileImage = nil
        followers = []
        following = []
        access = ""
        refresh = ""
        userID = ""
    }
    
}
