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
        label.text = "이메일"
        label.numberOfLines = 5
        return label
    }()
    lazy var joinButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입하기", for: .normal)
        button.configuration = .borderedProminent()
        button.addTarget(self, action: #selector(signup), for: .touchUpInside)
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
                                        password: passwordField.textField.rx.text.orEmpty,
                                        nickname: nicknameField.textField.rx.text.orEmpty,
                                        birthday: birthdayField.textField.rx.text.orEmpty,
                                        phoneNumber: phoneField.textField.rx.text.orEmpty,
                                        tap: joinButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.emailValidation
            .bind(with: self) { owner, result in
                
            }
            .disposed(by: disposeBag)
        
        output.passwordValidation
            .bind(with: self) { owner, value in
                owner.passwordValidLabel.text = value.text
                owner.passwordValidLabel.textColor = value.valid ? .systemBlue : .systemRed
            }
            .disposed(by: disposeBag)
        
        output.nicknameValidation
            .bind(with: self) { owner, value in
                owner.phoneValidLabel.textColor = value.valid ? .systemBlue : .systemRed
            }
            .disposed(by: disposeBag)
        
        output.phoneValidation
            .bind(with: self) { owner, value in
                owner.phoneValidLabel.textColor = value.valid ? .systemBlue : .systemRed
                owner.phoneValidLabel.text = value.text
            }
            .disposed(by: disposeBag)
        
        output.ageValidation
            .bind(with: self) { owner, value in
                owner.birthInfoLabel.text = value.text
                owner.birthInfoLabel.textColor = value.valid ? .systemBlue : .systemRed
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
                owner.showAlert(title: "완료", message: "")
            }
            .disposed(by: disposeBag)
        
    }
    
}

// Network Functions
extension JoinViewController {
    
    @objc private func signup() {
        
        let joinBody = JoinBody(email: emailField.textField.text ?? "",
                                password: passwordField.textField.text ?? "",
                                nick: nicknameField.textField.text ?? "", 
                                phoneNum: "",
                                birthDay: birthdayField.textField.text)
        
        NetworkManager.shared.join(body: joinBody) { response in 
            
        }
        
        
    }
    
    @objc private func emailDuplicationCheck() {
        
    }
    
    @objc private func nicknameDuplicationCheck() {
        
        
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
            make.height.equalTo(50)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(-1.5)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        nicknameField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(-1.5)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        birthdayField.snp.makeConstraints { make in
            make.top.equalTo(nicknameField.snp.bottom).offset(-1.5)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        phoneField.snp.makeConstraints { make in
            make.top.equalTo(birthdayField.snp.bottom).offset(-1.5)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
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

