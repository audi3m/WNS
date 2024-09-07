//
//  LoginViewController.swift
//  WNS
//
//  Created by J Oh on 8/14/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class LoginViewController: BaseViewController {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "wineglass")
        view.contentMode = .scaleAspectFit
        view.tintColor = .label
        return view
    }()
    let emailField = OutlineField(fieldType: .emailForLogin, cornerType: .top)
    let passwordField = OutlineField(fieldType: .passwordForLogin, cornerType: .bottom)
    let validationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemRed
        label.numberOfLines = 0
        return label
    }()
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("로그인", for: .normal)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitle("회원가입", for: .normal)
        button.addTarget(self, action: #selector(signup), for: .touchUpInside)
        return button
    }()
    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        rxBind()
        
        emailField.textField.text = "d@d.com"
        passwordField.textField.text = "dddddddd"
    }
    
    
}

// Rx Functions
extension LoginViewController {
    
    private func rxBind() { 
        
        let input = LoginViewModel.Input(email: emailField.textField.rx.text.orEmpty,
                                         password: passwordField.textField.rx.text.orEmpty,
                                         loginTap: loginButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.validationText
            .bind(with: self) { owner, warning in
                owner.validationLabel.text = warning
            }
            .disposed(by: disposeBag)
        
        output.allValidation
            .bind(with: self) { owner, value in
                owner.loginButton.backgroundColor = value ? .systemBlue : .lightGray
                owner.loginButton.isEnabled = value
            }
            .disposed(by: disposeBag)
        
    }
    
}

// Network Functions
extension LoginViewController {
    
    @objc private func login() {
        
        guard let email = emailField.textField.text,
              let password = passwordField.textField.text else { return }
        
        let loginInfo = LoginBody(email: email, password: password)
        
        AccountNetworkManager.shared.login(body: loginInfo) { [weak self] response in
            guard let self else { return }
            AccountManager.shared.userID = response.userID
            AccountManager.shared.access = response.accessToken
            AccountManager.shared.refresh = response.refreshToken
            
            let vc = WineTabController()
            self.resetRootViewController(root: vc, withNav: false)
        } onResponseError: { [weak self] message in
            guard let self else { return }
            self.showAlert(title: "", message: message, ok: "확인") { }
        }
        
    }
    
    @objc private func signup() {
        let vc = JoinViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LoginViewController {
    
    private func configureView() {
        navigationItem.title = "로그인"
        
        view.addSubview(imageView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(validationLabel)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        
        imageView.snp.makeConstraints { make in
            make.bottom.equalTo(emailField.snp.top).offset(-50)
            make.centerX.equalTo(view)
            make.size.equalTo(100)
        }
        
        emailField.snp.makeConstraints { make in
            make.bottom.equalTo(passwordField.snp.top).offset(DesignSize.outlineWidth)
            make.horizontalEdges.equalTo(view).inset(30)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        
        passwordField.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.horizontalEdges.equalTo(view).inset(30)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view).inset(30)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(validationLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view).inset(30)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(30)
            make.centerX.equalTo(view)
            make.height.equalTo(20)
        }
    } 
}
