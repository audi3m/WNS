//
//  JoinViewController.swift
//  WNS
//
//  Created by J Oh on 8/14/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class JoinViewController: BaseViewController {
    
    let emailField: JoinField = {
        let view = JoinField(type: .email)
        return view
    }()
    lazy var emailDuplicationCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복 확인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGray2
        button.addTarget(self, action: #selector(emailDuplicationCheck), for: .touchUpInside)
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
    lazy var nicknameDuplicationCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복 확인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGray2
        button.addTarget(self, action: #selector(nicknameDuplicationCheck), for: .touchUpInside)
        return button
    }()
    let phoneNuberField: JoinField = {
        let view = JoinField(type: .phoneNumber)
        return view
    }()
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "생일"
        label.font = .systemFont(ofSize: 12)
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
    lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입하기", for: .normal)
        button.configuration = .borderedProminent()
        button.addTarget(self, action: #selector(signup), for: .touchUpInside)
        return button
    }()
    
    let viewModel = JoinViewModel()
    var validatedEmail = ""
    var validated = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        rxBind()
    }
    
    
}

// Rx Functions
extension JoinViewController {
    
    private func rxBind() {
        
        let input = JoinViewModel.Input()
        let output = viewModel.transform(input: input)
        
        
        
    }
    
}

// Network Functions
extension JoinViewController {
    
    @objc private func signup() {
        
        let joinBody = JoinBody(email: emailField.textField.text ?? "",
                                password: passwordField.textField.text ?? "",
                                nick: nicknameField.textField.text ?? "",
                                phoneNum: phoneNuberField.textField.text,
                                birthDay: birthdayPicker.date.formatted())
        
        NetworkManager.shared.join(body: joinBody) { response in 
            
        }
        
        
    }
    
    @objc private func emailDuplicationCheck() {
        if let email = emailField.textField.text {
            guard !email.isEmpty else {
                self.showAlert(title: "", message: "이메일을 입력하세요", ok: "확인") { }
                return
            }
            let body = EmailDuplicationCheckBody(email: email)
            NetworkManager.shared.emailDuplicateCheck(body: body) { response in
                self.showAlert(title: "", message: response.message, ok: "확인") {
                    self.setDuplicateButton(checked: true)
                    self.validatedEmail = email
                    // validatedEmail 변하면 다시 회색
                }
            }
        }
    }
    
    @objc private func nicknameDuplicationCheck() {
        
        
    }
    
    private func setDuplicateButton(checked: Bool) {
        emailDuplicationCheckButton.backgroundColor = checked ? .systemGreen : .systemGray2
        emailDuplicationCheckButton.setTitle(checked ? "가능" : "중복 확인", for: .normal)
        emailDuplicationCheckButton.isEnabled = checked ? false : true
        
    }
    
}

// View
extension JoinViewController {
    
    private func configureView() {
        navigationItem.title = "회원가입"
        
        view.addSubview(emailField)
        view.addSubview(emailDuplicationCheckButton)
        view.addSubview(passwordField)
        view.addSubview(nicknameField)
        view.addSubview(nicknameDuplicationCheckButton)
        view.addSubview(phoneNuberField)
        view.addSubview(birthdayLabel)
        view.addSubview(birthdayPicker)
        view.addSubview(birthdayValidLabel)
        view.addSubview(signupButton)
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
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
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(emailDuplicationCheckButton.snp.leading).offset(-10)
            make.height.equalTo(60)
        }
        
        nicknameDuplicationCheckButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameField.textField.snp.top)
            make.bottom.equalTo(nicknameField.textField.snp.bottom)
            make.trailing.equalTo(view).offset(-20)
            make.width.equalTo(70)
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
            make.height.equalTo(120)
        }
        
        signupButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
    }
    
}

