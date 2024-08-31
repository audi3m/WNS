//
//  GalleryButtonView.swift
//  WNS
//
//  Created by J Oh on 8/24/24.
//

import UIKit
import SnapKit
 
final class GalleryButtonView: UIView {
     
    let cameraImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "camera")
        view.tintColor = .label
        return view
    }()
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .label
        label.text = "3 / 5"
        return label
    }()
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 4
        view.addArrangedSubview(cameraImageView)
        view.addArrangedSubview(countLabel)
        return view
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
         
    }
}
