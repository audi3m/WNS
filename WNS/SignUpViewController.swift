//
//  SignUpViewController.swift
//  WNS
//
//  Created by J Oh on 8/14/24.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address"
        return field
    }()
    let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        return field
    }()
    let nicknameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Nickname"
        return field
    }()
    let phoneNumberField: UITextField = {
        let field = UITextField()
        
        return field
    }()
    let birthday: UITextField = {
        let field = UITextField()
        
        return field
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    
    
    
    
    
}

extension SignUpViewController {
    
    private func configureView() {
        
    }
    
    
    
}

