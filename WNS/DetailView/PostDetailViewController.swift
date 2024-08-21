//
//  PostDetailViewController.swift
//  WNS
//
//  Created by J Oh on 8/14/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class PostDetailViewController: BaseViewController {
    
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        return vc
    }()
    
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        rxBind()
    }
    
    
    
}

// Rx
extension PostDetailViewController {
    private func rxBind() {
        
        let input = DetailViewModel.Input()
        let output = viewModel.transform(input: input)
        
        
        
            
    }
}

// Functions
extension PostDetailViewController {
    
}

// View
extension PostDetailViewController {
    
    private func configureView() {
        
    }
    
    
    
}
