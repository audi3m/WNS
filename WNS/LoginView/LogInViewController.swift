//
//  LogInViewController.swift
//  WNS
//
//  Created by J Oh on 8/14/24.
//

import UIKit

final class LogInViewController: UIViewController {
    
    let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "이메일 주소"
        field.borderStyle = .roundedRect
        return field
    }()
    let emailValidLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "비밀번호"
        field.borderStyle = .roundedRect
        return field
    }()
    let passwordValidLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    
    
    
    
    
}

extension LogInViewController {
    
    private func configureView() {
        
    }
    
    
    
}
