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
    
    var nickname: String {
        get {
            return UserDefaults.standard.string(forKey: "nickname") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "nickname")
        }
    }
    
    var profile: String? {
        get {
            return UserDefaults.standard.string(forKey: "profile")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "profile")
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
    
    var isAdmin: Bool {
        userID == "66d1ff39dfc656014225765f"
    }
    
}

extension AccountManager {
    
    func setWtihResponse(body: LoginBody, response: LoginResponse) {
        email = body.email
        password = body.password
        nickname = response.nick
        profile = response.profileImage
        access = response.accessToken
        refresh = response.refreshToken
        userID = response.userID
    }
    
    func resetAccount() {
        access = ""
        refresh = ""
        userID = ""
    }
    
//    func login(handler: @escaping ((LoginResponse) -> Void)) {
//        let body = LoginBody(email: email, password: password)
//        AccountNetworkManager.shared.login(body: body) { response in
//            switch response {
//            case .success(let success):
//                <#code#>
//            case .failure(let failure):
//                <#code#>
//            }
//            handler(response)
//        } onResponseError: { message in
//            print(message)
//        }
//
//    }
}
