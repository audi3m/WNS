//
//  SelectionView.swift
//  WNS
//
//  Created by J Oh on 8/27/24.
//

import UIKit
import SnapKit
 
final class SelectionView: UIView {
    
    enum SelectionType {
        case system
        case light
        case dark
        
        var image: String {
            switch self {
            case .system:
                "iphone"
            case .light:
                "sun.max"
            case .dark:
                "moon"
            }
        }
    }
     
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: type.image)
        return view
    }()
    let checkView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "circle")
        return view
    }()
    
    let type: SelectionType
    
    init(type: SelectionType) {
        self.type = type
        super.init(frame: .zero)
        configureView()
    }
     
    override init(frame: CGRect) {
        self.type = .system
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(imageView)
        addSubview(checkView)
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self)
            make.size.equalTo(50)
        }
        checkView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalTo(self)
            make.size.equalTo(25)
        }
    }
}
