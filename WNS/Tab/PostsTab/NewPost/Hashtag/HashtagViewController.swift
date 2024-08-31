//
//  HashtagViewController.swift
//  WNS
//
//  Created by J Oh on 8/31/24.
//

import UIKit
import SnapKit

final class HashtagViewController: BaseViewController {
    
    let hashField: OutlineField = {
        let view = OutlineField(fieldType: .hashtag, cornerType: .all)
        return view
    }()
    
    
    let hashtagListLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

extension HashtagViewController {
    private func configureView() {
        navigationItem.title = "해시태그"
        
        view.addSubview(hashField)
        view.addSubview(hashtagListLabel)
        
        hashField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(DesignSize.fieldHorizontalPadding)
            make.height.equalTo(50)
        }
        hashtagListLabel.snp.makeConstraints { make in
            make.top.equalTo(hashField.snp.bottom).offset(20)
        }
    }
}
