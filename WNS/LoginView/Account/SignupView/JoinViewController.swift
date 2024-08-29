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
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "wineglass")
        view.tintColor = .label
        view.contentMode = .scaleAspectFit
        return view
    }()
    let emailField = OutlineField(fieldType: .email, cornerType: .top)
    let passwordField = OutlineField(fieldType: .password, cornerType: .middle)
    let nicknameField = OutlineField(fieldType: .nickname, cornerType: .middle)
    let birthdayField = OutlineField(fieldType: .birthday, cornerType: .middle)
    let phoneField = OutlineField(fieldType: .phone, cornerType: .bottom)
    lazy var validationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemRed
        label.numberOfLines = 0
        return label
    }()
    lazy var joinButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입하기", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(join), for: .touchUpInside)
        return button
    }()
    
    let viewModel = JoinViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        rxBind()
    }
    
}

// Rx Functions
extension JoinViewController {
    
    private func rxBind() {
        
        let input = JoinViewModel.Input(email: emailField.textField.rx.text.orEmpty,
                                        emailDuplicationTap: emailField.duplicationButton.rx.tap,
                                        password: passwordField.textField.rx.text.orEmpty,
                                        nickname: nicknameField.textField.rx.text.orEmpty,
                                        birthday: birthdayField.textField.rx.text.orEmpty,
                                        phoneNumber: phoneField.textField.rx.text.orEmpty,
                                        tap: joinButton.rx.tap,
                                        emailDupCheck: emailField.duplicationButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.validationText
            .bind(with: self) { owner, warning in
                owner.validationLabel.text = warning
            }
            .disposed(by: disposeBag)
        
        output.allValidation
            .bind(with: self) { owner, value in
                owner.joinButton.backgroundColor = value ? .systemBlue : .lightGray
                owner.joinButton.isEnabled = value
            }
            .disposed(by: disposeBag)
        
        output.tap
            .bind(with: self) { owner, _ in
                
            }
            .disposed(by: disposeBag)
        
    }
}

// Network Functions
extension JoinViewController {
    
    @objc private func join() {
        
        let joinBody = JoinBody(email: emailField.textField.text ?? "",
                                password: passwordField.textField.text ?? "",
                                nick: nicknameField.textField.text ?? "", 
                                birthDay: birthdayField.textField.text ?? "",
                                phoneNum: phoneField.textField.text)
        
        NetworkManager.shared.join(body: joinBody) { response in 
            
        }
    }
    
    @objc private func emailDuplicationCheck() {
        guard let email = emailField.textField.text else { return }
        let body = EmailDuplicationCheckBody(email: email)
        NetworkManager.shared.emailDuplicateCheck(body: body) { response in
            DispatchQueue.main.async {
                
            }
        }
    }
    
     
    
}

// View
extension JoinViewController {
    
    private func configureView() {
        navigationItem.title = "회원가입"
        
        view.addSubview(imageView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(nicknameField)
        view.addSubview(birthdayField)
        view.addSubview(phoneField)
        view.addSubview(validationLabel)
        view.addSubview(joinButton)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view)
            make.size.equalTo(100)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(60)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(-DesignSize.outlineWidth)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(60)
        }
        
        nicknameField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(-DesignSize.outlineWidth)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(60)
        }
        
        birthdayField.snp.makeConstraints { make in
            make.top.equalTo(nicknameField.snp.bottom).offset(-DesignSize.outlineWidth)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(60)
        }
        
        phoneField.snp.makeConstraints { make in
            make.top.equalTo(birthdayField.snp.bottom).offset(-DesignSize.outlineWidth)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(60)
        }
        
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view).inset(20)
        }
        
        joinButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        emailField.duplicationButton.addTarget(self, action: #selector(emailDuplicationCheck), for: .touchUpInside)
        
    }
    
}

