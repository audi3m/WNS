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
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: ProfileViewController())
        let addNew = UIViewController()
        
        vc1.tabBarItem = UITabBarItem(title: nil, image: TabItemImage.home.unselectedImage, selectedImage: TabItemImage.home.selectedImage)
        vc2.tabBarItem = UITabBarItem(title: nil, image: TabItemImage.search.unselectedImage, selectedImage: TabItemImage.search.selectedImage)
        vc3.tabBarItem = UITabBarItem(title: nil, image: TabItemImage.profile.unselectedImage, selectedImage: TabItemImage.profile.selectedImage)
        addNew.tabBarItem = UITabBarItem(title: "", image: TabItemImage.addNew.selectedImage, tag: 1)
        viewControllers = [vc1, vc2, addNew, vc3]
        
        tabBar.tintColor = .label
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
