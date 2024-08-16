//
//  JoinViewController.swift
//  WNS
//
//  Created by J Oh on 8/14/24.
//

import UIKit
import SnapKit

final class JoinViewController: UIViewController {
    
    let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "이메일 주소"
        field.borderStyle = .roundedRect
        field.font = .systemFont(ofSize: 15)
        return field
    }()
    let emailValidLabel: UILabel = {
        let label = UILabel()
        label.text = "유효한 이메일입니다"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    let emailDuplicationCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복 확인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGray2
        return button
    }()
    let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "비밀번호"
        field.borderStyle = .roundedRect
        field.font = .systemFont(ofSize: 15)
        return field
    }()
    let passwordValidLabel: UILabel = {
        let label = UILabel()
        label.text = "유효한 비밀번호입니다"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    let nicknameField: UITextField = {
        let field = UITextField()
        field.placeholder = "닉네임"
        field.borderStyle = .roundedRect
        field.font = .systemFont(ofSize: 15)
        return field
    }()
    let nicknameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "유효한 이메일입니다"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    let phoneNumberField: UITextField = {
        let field = UITextField()
        field.placeholder = "전화번호"
        field.keyboardType = .numberPad
        field.borderStyle = .roundedRect
        field.font = .systemFont(ofSize: 15)
        return field
    }()
    let phoneNumberValidLabel: UILabel = {
        let label = UILabel()
        label.text = "유효한 전화번호입니다"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "생일"
        return label
    }()
    let birthdayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .compact
        picker.datePickerMode = .date
        return picker
    }()
    let birthdayValidLabel: UILabel = {
        let label = UILabel()
        label.text = "만 19세 이상만 가입이 가능합니다"
        label.font = .systemFont(ofSize: 12)
        return label
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
        view.addSubview(emailValidLabel)
        view.addSubview(emailDuplicationCheckButton)
        view.addSubview(passwordField)
        view.addSubview(passwordValidLabel)
        view.addSubview(nicknameField)
        view.addSubview(nicknameValidLabel)
        view.addSubview(phoneNumberField)
        view.addSubview(phoneNumberValidLabel)
        view.addSubview(birthdayLabel)
        view.addSubview(birthdayPicker)
        view.addSubview(birthdayValidLabel)
        view.addSubview(signupButton)
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view).inset(20)
            make.trailing.equalTo(emailDuplicationCheckButton.snp.leading).offset(-10)
            make.height.equalTo(40)
        }
        
        emailValidLabel.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view).inset(24)
            make.height.equalTo(12)
        }
        
        emailDuplicationCheckButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view).offset(-20)
            make.width.equalTo(70)
            make.height.equalTo(40)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailValidLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(40)
        }
        
        passwordValidLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view).inset(24)
            make.height.equalTo(12)
        }
        
        nicknameField.snp.makeConstraints { make in
            make.top.equalTo(passwordValidLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(40)
        }
        
        nicknameValidLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view).inset(24)
            make.height.equalTo(12)
        }
        
        phoneNumberField.snp.makeConstraints { make in
            make.top.equalTo(nicknameValidLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(40)
        }
        
        phoneNumberValidLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view).inset(24)
            make.height.equalTo(12)
        }
        
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberValidLabel.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(20)
            make.height.equalTo(40)
        }
        
        birthdayPicker.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberValidLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(40)
        }
        
        birthdayValidLabel.snp.makeConstraints { make in
            make.top.equalTo(birthdayPicker.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view).inset(24)
            make.height.equalTo(12)
        }
        
        signupButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
    }
    
}

