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
    lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = AccountManager.shared.nickname
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = AccountManager.shared.email
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
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
    
    private func configureNavBar() {
        navigationItem.title = "프로필"
        
        let settings = UIBarButtonItem(image: UIImage(systemName: "switch.2"),
                                       style: .plain, target: self,
                                       action: #selector(settingsClicked))
        settings.tintColor = .label
        navigationItem.rightBarButtonItem = settings
    }
    
    private func configureView() {
        view.addSubview(profileImageView)
        view.addSubview(nicknameLabel)
        view.addSubview(emailLabel)
        view.addSubview(stackView)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(view).offset(15)
            make.size.equalTo(80)
        }
        nicknameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.centerY).offset(-1)
            make.leading.equalTo(profileImageView.snp.trailing).offset(20)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.centerY).offset(1)
            make.leading.equalTo(profileImageView.snp.trailing).offset(20)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}
