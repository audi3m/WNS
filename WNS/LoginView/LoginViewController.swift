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
    let passwordField = OutlineField(fieldType: .password, cornerType: .bottom)
    let validLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.configuration = .borderedProminent()
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
    }
    
    
}

// Rx Functions
extension LoginViewController {
    
    private func rxBind() { }
    
}

// Network Functions
extension LoginViewController {
    
    @objc private func login() {
        
        guard let email = emailField.textField.text,
              let password = passwordField.textField.text else { return }
        
        let loginInfo = LoginBody(email: email, password: password)
        
        NetworkManager.shared.login(body: loginInfo) { response in
            AccountManager.shared.userID = response.userID
            AccountManager.shared.access = response.accessToken
            AccountManager.shared.refresh = response.refreshToken
            
            let vc = MainPostViewController()
            self.resetRootViewController(root: vc, withNav: true)
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
        view.addSubview(validLabel)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        
        imageView.snp.makeConstraints { make in
            make.bottom.equalTo(emailField.snp.top).offset(-50)
            make.centerX.equalTo(view)
            make.size.equalTo(100)
        }
        
        emailField.snp.makeConstraints { make in
            make.bottom.equalTo(passwordField.snp.top).offset(1.5)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(60)
        }
        
        passwordField.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(60)
        }
        
        validLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view).inset(20)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(validLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(30)
            make.centerX.equalTo(view)
            make.height.equalTo(20)
        }
    } 
}
