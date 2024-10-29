//
//  ProfileViewController.swift
//  WNS
//
//  Created by J Oh on 8/18/24.
//

//import UIKit
import SwiftUI
import SnapKit
import PhotosUI
import RxSwift
import RxCocoa

// id, email, nick, phone, birthday, profile, followers, following, posts
final class ProfileViewController: BaseViewController {
    
    lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 40
        return view
    }()
    lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = AccountManager.shared.nick
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = AccountManager.shared.email
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("수정", for: .normal)
        button.configuration = .borderedProminent()
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        return button
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
    let postsCount = CountAndLabelView(type: .posts)
    let followersCount = CountAndLabelView(type: .followers)
    let followingsCount = CountAndLabelView(type: .followings)
    
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
    
    @objc private func editProfile() {
        let vc = EditProfileViewController()
        vc.hidesBottomBarWhenPushed = true
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
        view.addSubview(editButton)
        view.addSubview(stackView)
        
        profileImageView.setImageWithURL(with: AccountManager.shared.profileImage)
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
        editButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.trailing.equalTo(view).offset(-20)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        postsCount.countLabel.text = "\(AccountManager.shared.posts.count)"
        followersCount.countLabel.text = "\(AccountManager.shared.followers.count)"
        followingsCount.countLabel.text = "\(AccountManager.shared.following.count)"
        
    }
}
