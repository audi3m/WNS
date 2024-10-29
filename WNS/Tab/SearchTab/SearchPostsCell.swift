//
//  SearchPostsCell.swift
//  WNS
//
//  Created by J Oh on 9/9/24.
//

import UIKit
import SnapKit

final class SearchPostsCell: UITableViewCell {
    
    let firstImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = DesignSize.fieldCornerRadius
        view.clipsToBounds = true
        return view
    }()
    let userLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    var postData: Post?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configureView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
}

// Functions
extension SearchPostsCell {
    
    func configureData(data: Post) {
        firstImageView.setImageWithURL(with: data.files.first)
        userLabel.text = data.creator.nick
    }
    
}

// View
extension SearchPostsCell {
    
    private func configureView() {
        contentView.addSubview(firstImageView)
        contentView.addSubview(userLabel)
        
        firstImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(DesignSize.fieldPadding)
            make.size.equalTo(100)
        }
        
        userLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(DesignSize.fieldPadding)
        }
        
    }
}
