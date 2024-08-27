//
//  SettingsViewController.swift
//  WNS
//
//  Created by J Oh on 8/20/24.
//

import UIKit
import SnapKit

final class SettingsViewController: BaseViewController {
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createListLayout())
        
        return view
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureView()
    }
}

extension SettingsViewController {
    
    func configureView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalTo(view)
        }
    }
    
}

// CollectionView
extension SettingsViewController {
    
    
    
    
    
    private func createListLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
}
