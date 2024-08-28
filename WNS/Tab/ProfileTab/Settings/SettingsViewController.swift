//
//  SettingsViewController.swift
//  WNS
//
//  Created by J Oh on 8/20/24.
//

import UIKit
import SnapKit

final class SettingsViewController: BaseViewController {
    
    enum Section {
        case appearance, logout
    }
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createListLayout())
        view.delegate = self
        view.dataSource = self
        view.register(AppearanceCollectionViewCell.self, forCellWithReuseIdentifier: AppearanceCollectionViewCell.id)
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
extension SettingsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        if section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppearanceCollectionViewCell.id, for: indexPath) as? AppearanceCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        } else if section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.id, for: indexPath)
            
            return UICollectionViewCell()
        } else if section == 2 {
            return UICollectionViewCell()
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    private func createListLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
}
