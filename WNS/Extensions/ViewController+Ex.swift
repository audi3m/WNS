//
//  ViewController+Ex.swift
//  WNS
//
//  Created by J Oh on 8/17/24.
//

import UIKit

extension UIViewController {
    
    func showAlert(type: AlertType, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: type.title, message: type.message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let confirm = UIAlertAction(title: type.confirm, style: .default) { _ in
            completionHandler()
        }
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        present(alert, animated: true)
    }
    
    func resetRootViewController(root: UIViewController, withNav: Bool) {
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        if withNav {
            let nav = UINavigationController(rootViewController: root)
            sceneDelegate?.window?.rootViewController = nav
        } else {
            sceneDelegate?.window?.rootViewController = root
        }
        
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}

enum AlertType {
    case resign
    
    var title: String {
        switch self {
        case .resign: "탈퇴하기"
        }
    }
    
    var message: String {
        switch self {
        case .resign: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?"
        }
    }
    
    var confirm: String {
        switch self {
        case .resign: "확인"
        }
    }
    
}
