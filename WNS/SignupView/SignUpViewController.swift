//
//  SignUpViewController.swift
//  WNS
//
//  Created by J Oh on 8/14/24.
//

import UIKit
import SnapKit

final class SignUpViewController: UIViewController {
    
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
    let emailDuplicationButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복 확인", for: .normal)
        return button
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
    let nicknameField: UITextField = {
        let field = UITextField()
        field.placeholder = "닉네임"
        field.borderStyle = .roundedRect
        return field
    }()
    let nicknameValidLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    let phoneNumberField: UITextField = {
        let field = UITextField()
        field.placeholder = "전화번호"
        field.keyboardType = .numberPad
        field.borderStyle = .roundedRect
        return field
    }()
    let phoneNumberValidLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    let birthday: UIDatePicker = {
        let picker = UIDatePicker()
        
        return picker
    }()
    let birthdayValidLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입하기", for: .normal)
        return button
    }()
    
    let viewModel = SignupViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    
    
    
}

extension SignUpViewController {
    
    private func configureView() {
        
        view.addSubview(emailField)
        view.addSubview(emailValidLabel)
        view.addSubview(emailDuplicationButton)
        view.addSubview(passwordField)
        view.addSubview(passwordValidLabel)
        view.addSubview(nicknameField)
        view.addSubview(nicknameValidLabel)
        view.addSubview(phoneNumberField)
        view.addSubview(phoneNumberValidLabel)
        view.addSubview(birthday)
        view.addSubview(birthdayValidLabel)
        view.addSubview(signupButton)
        
        emailField.snp.makeConstraints { make in
            
        }
        
        emailValidLabel.snp.makeConstraints { make in
            
        }
        
        emailDuplicationButton.snp.makeConstraints { make in
            
        }
        
        passwordField.snp.makeConstraints { make in
            
        }
        
        passwordValidLabel.snp.makeConstraints { make in
            
        }
        
        nicknameField.snp.makeConstraints { make in
            
        }
        
        nicknameValidLabel.snp.makeConstraints { make in
            
        }
        
        phoneNumberField.snp.makeConstraints { make in
            
        }
        
        phoneNumberValidLabel.snp.makeConstraints { make in
            
        }
        
        birthday.snp.makeConstraints { make in
            
        }
        
        birthdayValidLabel.snp.makeConstraints { make in
            
        }
        
        signupButton.snp.makeConstraints { make in
            
        }
        
        
        
    }
    
    
}

