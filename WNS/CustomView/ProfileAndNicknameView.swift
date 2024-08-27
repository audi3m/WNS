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
        view.layer.cornerRadius = 15
        view.image = UIImage(systemName: "person.circle")
        view.tintColor = .label
        return view
    }()
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
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
            make.size.equalTo(30)
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
        }
        nicknameLabel.text = creator.nick
    }
}
