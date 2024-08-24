//
//  TestViewController.swift
//  WNS
//
//  Created by J Oh on 8/16/24.
//

import UIKit
import SnapKit

final class TestViewController: UIViewController {
     
    let cameraView: GalleryButtonView = {
        let view = GalleryButtonView()
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(cameraView)
        cameraView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(70)
        }
        
    }
}
