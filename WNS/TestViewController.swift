//
//  TestViewController.swift
//  WNS
//
//  Created by J Oh on 8/16/24.
//

import UIKit
import SnapKit

final class TestViewController: BaseViewController {
    
    let profileView: ProfileAndNicknameView = {
        let view = ProfileAndNicknameView()
        return view
    }()
    let cellBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    let imageView1: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sample1")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    let imageView2: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sample2")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    let imageView3: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sample3")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    let moreView: UILabel = {
        let label = UILabel()
        label.text = "+ 1"
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .black.withAlphaComponent(0.5)
        return label
    }()
    let wineNameLabel: UILabel = {
        let label = UILabel()
        label.text = "도그 포인트, 소비뇽 블랑 2017"
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let likeButton: UIImageView = {
        let view = UIImageView()
        view.image = ButtonImage.heart
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()
        configureBasicView()
        configureImages3()
        
    }
    
}

extension TestViewController {
    
    private func configureImage1() {
        cellBackground.addSubview(imageView1)
        
        imageView1.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(180)
        }
    }
    
    private func configureImages2() {
        cellBackground.addSubview(imageView1)
        cellBackground.addSubview(imageView2)
        
        imageView1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(180)
        }
        imageView2.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(imageView1.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
    }
    
    private func configureImages3() {
         
        cellBackground.addSubview(imageView1)
        cellBackground.addSubview(imageView2)
        cellBackground.addSubview(imageView3)
        
        imageView1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(180)
        }
        imageView2.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(imageView1.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
            make.height.equalTo(90)
        }
        imageView3.snp.makeConstraints { make in
            make.top.equalTo(imageView2.snp.bottom).offset(2)
            make.leading.equalTo(imageView1.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(imageView1.snp.bottom)
        }
    }
    
    private func configureImages3Hor() {
         
        cellBackground.addSubview(imageView1)
        cellBackground.addSubview(imageView2)
        cellBackground.addSubview(imageView3)
        
        imageView1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalTo(180)
        }
        imageView2.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(imageView1.snp.trailing).offset(2)
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalTo(180)
        }
        imageView3.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(imageView2.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
    }
    
    private func configureImages45() {
         
        cellBackground.addSubview(imageView1)
        cellBackground.addSubview(imageView2)
        cellBackground.addSubview(imageView3)
        cellBackground.addSubview(moreView)
        
        imageView1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(180)
        }
        imageView2.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(imageView1.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
            make.height.equalTo(90)
        }
        imageView3.snp.makeConstraints { make in
            make.top.equalTo(imageView2.snp.bottom).offset(2)
            make.leading.equalTo(imageView1.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(imageView1.snp.bottom)
        }
        moreView.snp.makeConstraints { make in
            make.top.equalTo(imageView2.snp.bottom).offset(2)
            make.leading.equalTo(imageView1.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(imageView1.snp.bottom)
        }
        
    }
    
    private func configureBasicView() {
        view.addSubview(profileView)
        view.addSubview(cellBackground)
        cellBackground.addSubview(wineNameLabel)
        cellBackground.addSubview(likeButton)
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view).inset(20)
        }
        cellBackground.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(250)
        }
        wineNameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        likeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
    
    private func configureNavBar() {
        let toggle = UIBarButtonItem(image: UIImage(systemName: "light.cylindrical.ceiling.inverse"),
                                   style: .plain, target: self,
                                   action: #selector(changeMode))
        
        navigationItem.rightBarButtonItems = [toggle]
        
    }
    
    @objc private func changeMode() {
        if overrideUserInterfaceStyle == .light {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }
}



