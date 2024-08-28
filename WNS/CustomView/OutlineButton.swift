//
//  OutlineButton.swift
//  WNS
//
//  Created by J Oh on 8/29/24.
//

import UIKit

final class OutlineButton: UIView {
    
    enum CornerType {
        case top, middle, bottom
    }
    
    lazy var outlineView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.5
        view.roundCorners(cornerType)
        return view
    }()
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle(name, for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.contentHorizontalAlignment = .leading
        return button
    }()
     
    let name: String
    let cornerType: Corner
    
    init(name: String, cornerType: Corner) {
        self.name = name
        self.cornerType = cornerType
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(outlineView)
        outlineView.addSubview(button)
        
        outlineView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
    }
}
