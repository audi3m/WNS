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
        
        let mainTab = UINavigationController(rootViewController: MainPostViewController())
        let searchTab = UINavigationController(rootViewController: SearchViewController())
        let addNew = UIViewController()
        let joinTab = UINavigationController(rootViewController: JoinViewController())
        let profileTab = UINavigationController(rootViewController: ProfileViewController())
        let testTab = UINavigationController(rootViewController: GPTTab())
        
        mainTab.tabBarItem = UITabBarItem(title: nil, image: TabItemImage.home.unselectedImage, selectedImage: TabItemImage.home.selectedImage)
        searchTab.tabBarItem = UITabBarItem(title: nil, image: TabItemImage.search.unselectedImage, selectedImage: TabItemImage.search.selectedImage)
        
        
        addNew.tabBarItem = UITabBarItem(title: "", image: TabItemImage.addNew.selectedImage, tag: 1)
        
        
        
        profileTab.tabBarItem = UITabBarItem(title: nil, image: TabItemImage.profile.unselectedImage, selectedImage: TabItemImage.profile.selectedImage)
        joinTab.tabBarItem = UITabBarItem(title: nil, image: TabItemImage.join.unselectedImage, selectedImage: TabItemImage.join.selectedImage)
        testTab.tabBarItem = UITabBarItem(title: nil, image: TabItemImage.login.unselectedImage, selectedImage: TabItemImage.login.selectedImage)

        viewControllers = [mainTab, addNew, profileTab, joinTab, testTab]
        
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
