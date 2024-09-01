//
//  OutlineNavigation.swift
//  WNS
//
//  Created by J Oh on 8/31/24.
//

import UIKit
import SnapKit

final class OutlineNavigation: UIView {
    
    enum CornerType {
        case top, middle, bottom
    }
    
    lazy var outlineView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = DesignSize.outlineWidth
        view.roundCorners(cornerType)
        return view
    }()
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .lightGray
        view.image = UIImage(systemName: image)
        return view
    }()
    lazy var fieldLabel: UILabel = {
        let label = UILabel()
        label.text = placeholer
        label.numberOfLines = lines
        label.textColor = .placeholderText
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    let navigateButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .label
        return button
    }()
     
    let placeholer: String
    let lines: Int
    let image: String
    let cornerType: Corner
    
    init(placeholer: String, lines: Int = 1, image: String, cornerType: Corner) {
        self.placeholer = placeholer
        self.lines = lines
        self.image = image
        self.cornerType = cornerType
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(outlineView)
        outlineView.addSubview(imageView)
        outlineView.addSubview(navigateButton)
        outlineView.addSubview(fieldLabel)
        
        outlineView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(DesignSize.fieldPadding)
            make.size.equalTo(DesignSize.fieldHeight - DesignSize.fieldPadding * 2)
        }
        navigateButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(DesignSize.fieldPadding)
            make.size.equalTo(DesignSize.fieldHeight - DesignSize.fieldPadding * 2)
        }
        fieldLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(DesignSize.fieldPadding)
            make.leading.equalTo(imageView.snp.trailing).offset(DesignSize.fieldPadding)
            make.trailing.equalTo(navigateButton.snp.leading).offset(-DesignSize.fieldPadding)
        }
    }
}
