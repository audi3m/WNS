//
//  WineAddViewController.swift
//  WNS
//
//  Created by J Oh on 8/29/24.
//

import UIKit
import SnapKit

final class WineAddViewController: BaseViewController {
    
    // 이름, 품종, 국가, 지역, 와이너리
    let nameField = OutlineField(fieldType: .wineName, cornerType: .top)
    let grapeField = OutlineField(fieldType: .variety, cornerType: .middle)
    let countryField = OutlineField(fieldType: .country, cornerType: .middle)
    let regionField = OutlineField(fieldType: .region, cornerType: .middle)
    let wineryField = OutlineField(fieldType: .winery, cornerType: .bottom)
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    
    
    
    
}

extension WineAddViewController {
    
    private func configureView() {
        navigationItem.title = "와인 추가 요청"
        
        view.addSubview(nameField)
        view.addSubview(grapeField)
        view.addSubview(countryField)
        view.addSubview(regionField)
        view.addSubview(wineryField)
        
        nameField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view).inset(30)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        grapeField.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(-DesignSize.outlineWidth)
            make.horizontalEdges.equalTo(view).inset(30)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        countryField.snp.makeConstraints { make in
            make.top.equalTo(grapeField.snp.bottom).offset(-DesignSize.outlineWidth)
            make.horizontalEdges.equalTo(view).inset(30)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        regionField.snp.makeConstraints { make in
            make.top.equalTo(countryField.snp.bottom).offset(-DesignSize.outlineWidth)
            make.horizontalEdges.equalTo(view).inset(30)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        wineryField.snp.makeConstraints { make in
            make.top.equalTo(regionField.snp.bottom).offset(-DesignSize.outlineWidth)
            make.horizontalEdges.equalTo(view).inset(30)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        
        nameField.iconImageView.tintColor = .label
        countryField.iconImageView.tintColor = .label
        regionField.iconImageView.tintColor = .label
        
        
        
    }
    
}
