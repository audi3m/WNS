//
//  SettingsViewController.swift
//  WNS
//
//  Created by J Oh on 8/20/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SettingsViewController: BaseViewController {
    
    
    
    
    
    
    
    
    let viewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        rxBind()
    }
    
    
    
    
    
    
}

// Rx
extension SettingsViewController {
    private func rxBind() {
        
        let input = SettingsViewModel.Input()
        let output = viewModel.transform(input: input)
        
        
        
            
    }
}

// View
extension SettingsViewController {
    
    private func configureView() {
        navigationItem.title = "설정"
        
        
        
        
        
        
    }
    
    
    
}

