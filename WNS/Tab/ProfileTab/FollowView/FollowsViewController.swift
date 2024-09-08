//
//  FollowsViewController.swift
//  WNS
//
//  Created by J Oh on 8/18/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class FollowsViewController: BaseViewController {
    
    
    
    
    
    
    
    let viewModel = FollowsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        rxBind()
    }
    
    
    
    
    
    
}

// Rx
extension FollowsViewController {
    private func rxBind() {
        
        let input = FollowsViewModel.Input()
        let output = viewModel.transform(input: input)
        print(output)
            
    }
}

// View
extension FollowsViewController {
    
    private func configureView() {
        navigationItem.title = "닉네임"
        
        
        
        
        
        
    }
    
    
    
}
