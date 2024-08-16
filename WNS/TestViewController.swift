//
//  TestViewController.swift
//  WNS
//
//  Created by J Oh on 8/16/24.
//

import UIKit
import SnapKit
import TextFieldEffects

final class TestViewController: UIViewController {
    
//    let field1 = JoinTextField(type: .email)
//    let field2 = JoinTextField(type: .password)
//    let field3 = JoinTextField(type: .nickname)
//    let field4 = JoinTextField(type: .phone)
    
    let emailTextField = HoshiTextField()
    let passwordTextField = HoshiTextField()
    let nicknameTextField = HoshiTextField()
    let phoneNumberTextField = HoshiTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(nicknameTextField)
        view.addSubview(phoneNumberTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        emailTextField.placeholderColor = .lightGray
        emailTextField.borderActiveColor = .systemBlue
        emailTextField.borderInactiveColor = .lightGray
        emailTextField.placeholder = "이메일을 입력하세요"
        
        passwordTextField.placeholderColor = .lightGray
        passwordTextField.borderActiveColor = .systemBlue
        passwordTextField.borderInactiveColor = .lightGray
        passwordTextField.placeholder = "비밀번호를 입력하세요"
        
        nicknameTextField.placeholderColor = .lightGray
        nicknameTextField.borderActiveColor = .systemBlue
        nicknameTextField.borderInactiveColor = .lightGray
        nicknameTextField.placeholder = "닉네임을 입력하세요"
        
        phoneNumberTextField.placeholderColor = .lightGray
        phoneNumberTextField.borderActiveColor = .systemBlue
        phoneNumberTextField.borderInactiveColor = .lightGray
        phoneNumberTextField.placeholder = "전화번호를 입력하세요"
        
//        view.addSubview(field1)
//        view.addSubview(field2)
//        view.addSubview(field3)
//        view.addSubview(field4)
//        
//        field1.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.horizontalEdges.equalTo(view).inset(20)
//        }
//        
//        field2.snp.makeConstraints { make in
//            make.top.equalTo(field1.snp.bottom).offset(20)
//            make.horizontalEdges.equalTo(view).inset(20)
//        }
//        
//        field3.snp.makeConstraints { make in
//            make.top.equalTo(field2.snp.bottom).offset(20)
//            make.horizontalEdges.equalTo(view).inset(20)
//        }
//        
//        field4.snp.makeConstraints { make in
//            make.top.equalTo(field3.snp.bottom).offset(20)
//            make.horizontalEdges.equalTo(view).inset(20)
//        }
//        
//        field1.validationLabel.text = "8자리 이상 입력하세요"
//        field1.validationLabel.textColor = .red
//        
//        field2.validationLabel.text = "이메일 형식에 맞춰주세요"
//        field2.validationLabel.textColor = .red
    }
    
}
