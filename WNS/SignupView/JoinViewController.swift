//
//  JoinViewController.swift
//  WNS
//
//  Created by J Oh on 8/14/24.
//

import UIKit
import SnapKit

final class JoinViewController: UIViewController {
    
    let emailField: JoinField = {
        let view = JoinField(type: .email)
        return view
    }()
    let emailDuplicationCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복 확인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGray2
        return button
    }()
    let passwordField: JoinField = {
        let view = JoinField(type: .password)
        return view
    }()
    let nicknameField: JoinField = {
        let view = JoinField(type: .nickname)
        return view
    }()
    let phoneNuberField: JoinField = {
        let view = JoinField(type: .phoneNumber)
        return view
    }()
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "생일"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    let birthdayValidLabel: UILabel = {
        let label = UILabel()
        label.text = "만 19세 이상만 가입이 가능합니다"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    let birthdayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        return picker
    }()
    let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입하기", for: .normal)
        button.configuration = .borderedProminent()
        return button
    }()
    
    let viewModel = JoinViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    
}

extension JoinViewController {
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "회원가입"
        
        view.addSubview(emailField)
        view.addSubview(emailDuplicationCheckButton)
        view.addSubview(passwordField)
        view.addSubview(nicknameField)
        view.addSubview(phoneNuberField)
        view.addSubview(birthdayLabel)
        view.addSubview(birthdayPicker)
        view.addSubview(birthdayValidLabel)
        view.addSubview(signupButton)
        
//        emailField.validationLabel.text = "유효한 이메일입니다"
        emailField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view).inset(20)
            make.trailing.equalTo(emailDuplicationCheckButton.snp.leading).offset(-10)
            make.height.equalTo(60)
        }
        
        emailDuplicationCheckButton.snp.makeConstraints { make in
            make.top.equalTo(emailField.textField.snp.top)
            make.bottom.equalTo(emailField.textField.snp.bottom)
            make.trailing.equalTo(view).offset(-20)
            make.width.equalTo(70)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(60)
        }
        
        nicknameField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(60)
        }
        
        phoneNuberField.snp.makeConstraints { make in
            make.top.equalTo(nicknameField.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(60)
        }
        
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneNuberField.snp.bottom).offset(15)
            make.leading.equalTo(view).offset(20)
            make.height.equalTo(15)
        }
        
        birthdayValidLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneNuberField.snp.bottom).offset(15)
            make.leading.equalTo(birthdayLabel.snp.trailing).offset(10)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(15)
        }
        
        birthdayPicker.snp.makeConstraints { make in
            make.top.equalTo(birthdayLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(100)
        }
        
        signupButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
    }
    
}

