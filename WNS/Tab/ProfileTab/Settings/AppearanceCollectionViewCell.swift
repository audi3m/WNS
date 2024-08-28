//
//  AppearanceCollectionViewCell.swift
//  WNS
//
//  Created by J Oh on 8/26/24.
//

import UIKit
import SnapKit

final class AppearanceCollectionViewCell: UICollectionViewCell {
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(system)
        view.addArrangedSubview(light)
        view.addArrangedSubview(dark)
        view.axis = .horizontal
        view.distribution = .equalSpacing
        return view
    }()
    
    let system: SelectionView = {
        let view = SelectionView(type: .system)
        return view
    }()
    let light: SelectionView = {
        let view = SelectionView(type: .light)
        return view
    }()
    let dark: SelectionView = {
        let view = SelectionView(type: .dark)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(stackView)
        stackView.addSubview(system)
        stackView.addSubview(light)
        stackView.addSubview(dark)
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
      
}
