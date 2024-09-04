//
//  ProfileAndNicknameView.swift
//  WNS
//
//  Created by J Oh on 8/23/24.
//

import UIKit
import SnapKit
 
final class ProfileAndNicknameView: UIView {
      
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 18
        view.image = UIImage(systemName: "person.circle")
        view.tintColor = .label
        return view
    }()
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "Wine_Lover"
        return label
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(profileImageView)
        addSubview(nicknameLabel)

        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(10)
            make.size.equalTo(36)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalTo(profileImageView.snp.centerY)
        }
    }
    
    func setProfile(creator: Creator) {
        if let image = creator.profileImage, !image.isEmpty {
            profileImageView.setImageWithURL(with: image)
        } else {
            profileImageView.image = UIImage(named: "sample")
        }
        nicknameLabel.text = creator.nick
    }
}
