//
//  ProfileViewController.swift
//  WNS
//
//  Created by J Oh on 8/18/24.
//

//import UIKit
import SwiftUI
import SnapKit
import RxSwift
import RxCocoa

// id, email, nick, phone, birthday, profile, followers, following, posts
final class ProfileViewController: BaseViewController {
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 40
        view.backgroundColor = .systemCyan
        return view
    }()
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        view.addArrangedSubview(postsCount)
        view.addArrangedSubview(followersCount)
        view.addArrangedSubview(followingsCount)
        return view
    }()
    let postsCount: CountAndLabelView = {
        let view = CountAndLabelView(type: .posts)
        return view
    }()
    let followersCount: CountAndLabelView = {
        let view = CountAndLabelView(type: .followers)
        return view
    }()
    let followingsCount: CountAndLabelView = {
        let view = CountAndLabelView(type: .followings)
        return view
    }()
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 aaaaa@aaaa.com"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임 AppleApps"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "전화번호 010-1234-1234"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "2020년 8월 20일"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        rxBind()
    }
    
    
}

// Rx
extension ProfileViewController {
    
    private func rxBind() { }
    
}

// Functions
extension ProfileViewController {
    @objc private func settingsClicked() {
        let vc = SettingsViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func viewFollows() {
        let vc = FollowsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// View
extension ProfileViewController {
    
    private func configureView() {
        
        navigationItem.title = "닉네임 자리"
        
        let settings = UIBarButtonItem(image: UIImage(systemName: "switch.2"),
                                       style: .plain, target: self,
                                       action: #selector(settingsClicked))
        settings.tintColor = .label
        navigationItem.rightBarButtonItem = settings
        
        view.addSubview(profileImageView)
        view.addSubview(stackView)
        view.addSubview(emailLabel)
        view.addSubview(nicknameLabel)
        view.addSubview(phoneLabel)
        view.addSubview(birthdayLabel) 
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(view).offset(15)
            make.size.equalTo(80)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(15)
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.trailing.equalTo(view).offset(-15)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(15)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(4)
            make.leading.equalTo(view).offset(15)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            make.leading.equalTo(view).offset(15)
        }
        
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(4)
            make.leading.equalTo(view).offset(15)
        }
    }
}
