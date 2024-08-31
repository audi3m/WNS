//
//  WineListManager.swift
//  WNS
//
//  Created by J Oh on 8/31/24.
//

import Foundation

final class WineListManager {
    
    static let shared = WineListManager()
    private init() { }
    
//    let wineList: [Wine]
    
    var wineListVersion: Double {
        get {
            return UserDefaults.standard.double(forKey: "wineListVersion")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "wineListVersion")
        }
    }
    
    var wineListJSON: String {
        get {
            return UserDefaults.standard.string(forKey: "wineListJSON") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "wineListJSON")
        }
    }
    
    var wineList: [Wine] {
        get {
            guard let jsonData = wineListJSON.data(using: .utf8) else { return [] }
            do {
                let decoder = JSONDecoder()
                let wines = try decoder.decode([Wine].self, from: jsonData)
                return wines
            } catch {
                print("Failed: \(error)")
                return []
            }
        }
    }
    
}

