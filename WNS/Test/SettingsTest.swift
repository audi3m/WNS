//
//  SettingsTest.swift
//  WNS
//
//  Created by J Oh on 8/26/24.
//

import UIKit
import SnapKit

class AppearanceCollectionViewCell2: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "circle"))
        imageView.tintColor = .secondaryLabel
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(imageView)
        contentView.addSubview(checkmarkImageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.centerX.equalToSuperview()
            make.size.equalTo(50)
        }
        checkmarkImageView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(25)
        }
        
    }
    
    fileprivate func configure(with mode: AppearanceMode, isSelected: Bool) {
        imageView.image = UIImage(systemName: mode.iconName)
        imageView.tintColor = isSelected ? .label : .secondaryLabel
        checkmarkImageView.image = isSelected ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
        checkmarkImageView.tintColor = isSelected ? .label : .secondaryLabel
    }
}

class AppearanceSelectionViewController: UIViewController {
    
    private var selectedMode: AppearanceMode = .system
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 150)
        layout.minimumLineSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AppearanceCollectionViewCell2.self, forCellWithReuseIdentifier: AppearanceCollectionViewCell2.id)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self

        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}

extension AppearanceSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppearanceMode.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppearanceCollectionViewCell2.id, for: indexPath) as! AppearanceCollectionViewCell2
        let mode = AppearanceMode.allCases[indexPath.item]
        cell.configure(with: mode, isSelected: mode == selectedMode)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMode = AppearanceMode.allCases[indexPath.item]
        collectionView.reloadData()
        // 선택된 모드에 따라 Appearance 변경 로직을 추가하면 됩니다.
    }
}

private enum AppearanceMode: String, CaseIterable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"

    var iconName: String {
        switch self {
        case .system: return "iphone"
        case .light: return "sun.max"
        case .dark: return "moon"
        }
    }
}
