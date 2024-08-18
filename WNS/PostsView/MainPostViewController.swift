//
//  MainPostViewController.swift
//  WNS
//
//  Created by J Oh on 8/14/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MainPostViewController: BaseViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        rxBind()
    }
    
    
}

// Rx
extension MainPostViewController {
    
    private func rxBind() {
        
    }
}

// Functions
extension MainPostViewController {
    @objc private func profileButtonClicked() { 
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// View
extension MainPostViewController {
    
    private func configureView() {
        navigationItem.title = "POST"
        
        let profile = UIBarButtonItem(image: UIImage(systemName: "person.circle"),
                                      style: .plain, target: self,
                                      action: #selector(profileButtonClicked))
        
        navigationItem.rightBarButtonItem = profile
        
        
    }
    
    
}
