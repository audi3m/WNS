//
//  SearchViewController.swift
//  WNS
//
//  Created by J Oh on 8/26/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureView()
        rxBind()
    }
    
}

// Rx
extension SearchViewController {
    private func rxBind() { }
}

// Functions
extension PostDetailViewController {
    
    
    
    
}

// View
extension SearchViewController {
    
    private func configureNavBar() {
        navigationItem.title = "검색"
        
        
    }
    
    private func configureView() {
        
        
        
    }
     
}
 
