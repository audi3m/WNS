//
//  ThemeManager.swift
//  WNS
//
//  Created by J Oh on 9/2/24.
//

import UIKit

enum AppTheme: String {
    case light
    case dark
    case system
}

final class ThemeManager {
    
    static let shared = ThemeManager()
    private init() { }
     
    private(set) var currentTheme: AppTheme = .system
     
    var savedTheme: AppTheme {
        get {
            if let savedValue = UserDefaults.standard.string(forKey: "selectedTheme"),
               let theme = AppTheme(rawValue: savedValue) {
                return theme
            } else {
                return .system
            }
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: "selectedTheme")
        }
    }
     
    func applyTheme(_ theme: AppTheme, to window: UIWindow? = nil) {
        currentTheme = theme
        
         if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = interfaceStyle(for: theme)
            }
        } else {
             window?.overrideUserInterfaceStyle = interfaceStyle(for: theme)
        }
        
         savedTheme = theme
    }
    
     func loadSavedTheme() {
        let theme = savedTheme
        applyTheme(theme)
    }
    
     private func interfaceStyle(for theme: AppTheme) -> UIUserInterfaceStyle {
        switch theme {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return .unspecified
        }
    }
}
