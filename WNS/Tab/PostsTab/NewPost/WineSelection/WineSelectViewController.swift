//
//  WineSelectViewController.swift
//  WNS
//
//  Created by J Oh on 8/31/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

final class WineSelectViewController: BaseViewController, UICollectionViewDelegate {
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.backgroundImage = UIImage()
        view.placeholder = "이름, 품종, 지역 등을 검색해보세요"
        return view
    }()
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.keyboardDismissMode = .onDrag
        view.delegate = self
        view.register(WineInfoCollectionViewListCell.self, forCellWithReuseIdentifier: WineInfoCollectionViewListCell.id)
        return view
    }()
    
    let viewModel = WineSelectViewModel()
    let disposeBag = DisposeBag()
    var sendSelectedWine: ((Wine) -> Void)?
    var selectedWine: Wine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        rxBind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let selectedWine {
            sendSelectedWine?(selectedWine)
        }
    }
    
}

extension WineSelectViewController {
    private func rxBind() {
        let input = WineSelectViewModel.Input(query: searchBar.rx.text.orEmpty)
        let output = viewModel.transform(input: input)
        
        output.searchResults
            .bind(to: collectionView.rx.items(cellIdentifier: WineInfoCollectionViewListCell.id, cellType: WineInfoCollectionViewListCell.self)) { item, wine, cell in
                cell.setData(wine: wine)
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .withLatestFrom(output.searchResults) { indexPath, wines in
                wines[indexPath.item]
            }
            .bind(with: self) { owner, selectedWine in
                owner.showAlertWithChoice(title: "", message: "이 와인을 선택하시겠습니까?", ok: "확인") {
                    DispatchQueue.main.async {
                        owner.selectedWine = selectedWine
                        owner.navigationController?.popViewController(animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
        
    }
}

// View
extension WineSelectViewController {
    private func configureView() {
        navigationItem.title = "와인선택"
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}
