//
//  NewPostViewController.swift
//  WNS
//
//  Created by J Oh on 8/18/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class NewPostViewController: BaseViewController {
    
    let titleTextField: UITextField = {
        let field = UITextField()
        
        return field
    }()
    let hashtagTextField: UITextField = {
        let field = UITextField()
        
        return field
    }()
    let contentTextField: UITextField = {
        let field = UITextField()
        
        return field
    }()
    
    lazy var postButton: UIButton = {
        let button = UIButton()
        
        button.addTarget(self, action: #selector(postButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let viewModel = NewPostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        rxBind()
    }
    
     
    
}

// Rx
extension NewPostViewController {
    
    private func rxBind() {
        
        let input = NewPostViewModel.Input()
        let output = viewModel.transform(input: input)
        
    }
    
}

// Functions
extension NewPostViewController {
    
    @objc private func postButtonClicked() {
        
    }
    
    @objc private func dismissView() {
        dismiss(animated: true)
    }
    
}

// View
extension NewPostViewController {
    
    private func configureView() {
        navigationItem.title = "새로운 포스트"
        
        
        let close = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(dismissView))
        
        navigationItem.leftBarButtonItem = close
        
        
    }
    
}
