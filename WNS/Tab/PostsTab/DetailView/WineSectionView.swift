//
//  WineSectionView.swift
//  WNS
//
//  Created by J Oh on 9/1/24.
//

import UIKit
import SnapKit

final class WineSectionView: UIView {
    
    let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "와인정보"
        return label
    }()
    let backgroundColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        return view
    }()
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        return view
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()
    let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    let wineryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    let varietyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    let placeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
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
        addSubview(sectionTitleLabel)
        addSubview(backgroundColorView)
        backgroundColorView.addSubview(imageView)
        backgroundColorView.addSubview(nameLabel)
        backgroundColorView.addSubview(typeLabel)
        backgroundColorView.addSubview(wineryLabel)
        backgroundColorView.addSubview(varietyLabel)
        backgroundColorView.addSubview(placeLabel)
        
        sectionTitleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        backgroundColorView.snp.makeConstraints { make in
            make.top.equalTo(sectionTitleLabel.snp.bottom).offset(13)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(DesignSize.fieldPadding)
            make.width.equalTo(80)
            make.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.top)
            make.leading.equalTo(imageView.snp.trailing).offset(DesignSize.fieldPadding)
            make.trailing.equalTo(typeLabel.snp.leading).offset(-DesignSize.fieldPadding)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.top)
            make.trailing.equalToSuperview().offset(-DesignSize.fieldPadding)
            make.size.equalTo(20)
        }
        
        varietyLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.leading.equalTo(imageView.snp.trailing).offset(DesignSize.fieldPadding)
            make.trailing.equalTo(typeLabel.snp.leading).offset(-DesignSize.fieldPadding)
        }
        
        wineryLabel.snp.makeConstraints { make in
            make.top.equalTo(varietyLabel.snp.bottom).offset(2)
            make.leading.equalTo(imageView.snp.trailing).offset(DesignSize.fieldPadding)
            make.trailing.equalTo(typeLabel.snp.leading).offset(-DesignSize.fieldPadding)
        }
        
        placeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.bottom)
            make.leading.equalTo(imageView.snp.trailing).offset(DesignSize.fieldPadding)
        }
        
    }
    
    func setData(wine: Wine) { 
        let url = URL(string: wine.imageURL)
        imageView.kf.setImage(with: url)
        
        nameLabel.text = wine.name
        
        typeLabel.text = wine.letter
        typeLabel.backgroundColor = wine.type == "Red" ? .redWine : .whiteWine
        typeLabel.textColor = wine.type == "Red" ? .white : .black
        
        let winery = "By " + wine.winery
        let range = (winery as NSString).range(of: "By ")
        let attributedString = NSMutableAttributedString(string: winery)
        attributedString.addAttribute(.foregroundColor, value: UIColor.secondaryLabel, range: range)
        
        wineryLabel.attributedText = attributedString
        
        varietyLabel.text = wine.variety
        placeLabel.text = wine.place
        
    }
    
}

