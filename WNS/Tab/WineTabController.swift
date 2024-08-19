//
//  WineTabController.swift
//  WNS
//
//  Created by J Oh on 8/18/24.
//

// Home, New, Profile

import UIKit

final class WineTabController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: MainPostViewController())
        let vc2 = UINavigationController(rootViewController: ProfileViewController())
        let addNew = UIViewController()
        
        vc1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house.fill"), selectedImage: nil)
        vc2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.crop.circle"), selectedImage: nil)
        addNew.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "plus.square",
                                                        withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)), tag: 1)
        
        viewControllers = [vc1, addNew, vc2]

        delegate = self
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 1 {
            
            let vc = NewPostViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true, completion: nil)
            return false
        }
        return true
    }
}
