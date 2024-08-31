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
    let wineLabel: UILabel = {
        let label = UILabel()
        label.text = "와인선택"
        label.textColor = .placeholderText
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .label
        return button
    }()
     
    let image: String
    let cornerType: Corner
    
    init(image: String, cornerType: Corner) {
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
        outlineView.addSubview(button)
        outlineView.addSubview(wineLabel)
        
        outlineView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(DesignSize.fieldPadding)
            make.size.equalTo(DesignSize.fieldHeight - DesignSize.fieldPadding * 2)
        }
        button.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview().inset(DesignSize.fieldPadding)
            make.size.equalTo(DesignSize.fieldHeight - DesignSize.fieldPadding * 2)
        }
        wineLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(DesignSize.fieldPadding)
            make.leading.equalTo(imageView.snp.trailing).offset(DesignSize.fieldPadding)
            make.trailing.equalTo(button.snp.leading).offset(-DesignSize.fieldPadding)
            
        }
        
    }
}
