//
//  NewPostViewController.swift
//  WNS
//
//  Created by J Oh on 8/18/24.
//

import UIKit
import SnapKit
import PhotosUI
import RxSwift
import RxCocoa

struct ImageItem: Identifiable {
    let id = UUID().uuidString
    let image: UIImage
}

final class NewPostViewController: BaseViewController {
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.keyboardDismissMode = .onDrag
        return view
    }()
    private let contentView = UIView()
    lazy private var imagesCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout(size: CGSize(width: 80, height: 80)))
        view.contentInset = UIEdgeInsets(top: 0, left: DesignSize.fieldHorizontalPadding, bottom: 0, right: DesignSize.fieldHorizontalPadding)
        view.showsHorizontalScrollIndicator = false
        view.register(NewPostImageCell.self, forCellWithReuseIdentifier: NewPostImageCell.id)
        view.register(GalleryButtonCell.self, forCellWithReuseIdentifier: GalleryButtonCell.id)
        view.delegate = self
        view.dataSource = self
        return view
    }()
     
    let wineSelection = OutlineNavigation(image: "wineglass", cornerType: .all)
    let titleField = OutlineField(fieldType: .title, cornerType: .top)
    let hashtagField = OutlineField(fieldType: .hashtag, cornerType: .middle)
    let contentsField = OutlineField(fieldType: .contents, cornerType: .bottom)
    
    lazy private var postButton: UIButton = {
        let button = UIButton()
        button.configuration = .borderedProminent()
        button.setTitle("업로드", for: .normal)
        button.addTarget(self, action: #selector(postButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let viewModel = NewPostViewModel()
    private var selectedImages = [ImageItem]()
    var selectedWine: Wine? {
        didSet {
            dump(selectedWine)
        }
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setButtons()
        rxBind()
    }
}

// Rx
extension NewPostViewController {
    private func rxBind() { }
}

// PhotosUI
extension NewPostViewController: PHPickerViewControllerDelegate {
    
    private func openGallery() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 5
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        let group = DispatchGroup()
        
        for (index, result) in results.enumerated() {
            guard index < 5 else { break }
            group.enter()
            
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
                defer { group.leave() }
                if let image = object as? UIImage {
                    self?.selectedImages.append(ImageItem(image: image))
                    if let count = self?.selectedImages.count, count > 5 {
                        self?.showAlert(title: "", message: "이미지는 최대 5개까지 업로드 가능합니다", ok: "확인") { }
                    }
                    self?.selectedImages = Array(self?.selectedImages.prefix(5) ?? [])
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.imagesCollectionView.reloadData()
        }
    }
}

// Button Functions
extension NewPostViewController {
    
    @objc private func showWineSelectionView() {
        let vc = WineSelectViewController()
        vc.sendSelectedWine = { [weak self] wine in
            guard let self else { return }
            self.selectedWine = wine
            self.wineSelection.wineLabel.text = wine.name
            self.wineSelection.wineLabel.textColor = .label
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func postButtonClicked() {
        guard let selectedWine else { return }
        guard let wineString = selectedWine.toJsonString() else { return }
        let hashtag = selectedWine.nameForHashtag + "hashtag by users"
        
        NetworkManager.shared.postImages(items: selectedImages) { [weak self] response in
            guard let self else { return }
            let body = PostBody(title: self.titleField.textField.text,
                                content: hashtag,
                                content1: wineString,
                                content2: contentsField.textField.text,
                                product_id: ProductID.forUsers.rawValue,
                                files: response.files)
            NetworkManager.shared.writePost(body: body) { [weak self] post in
                guard let self else { return }
                print(post)
                self.dismissView()
            }
        }
    }
}

extension NewPostViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        selectedImages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryButtonCell.id, for: indexPath) as! GalleryButtonCell
            cell.setCount(num: selectedImages.count)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewPostImageCell.id, for: indexPath) as! NewPostImageCell
            let data = selectedImages[indexPath.item - 1]
            cell.imageView.image = data.image
            cell.deleteButton.tag = indexPath.item
            cell.deleteButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 { openGallery() }
    }
    
    private func layout(size: CGSize) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = size
        return layout
    }
    
    @objc func deleteItem(_ sender: UIButton) {
        let tag = sender.tag - 1
        selectedImages.remove(at: tag)
        imagesCollectionView.reloadData()
    }
}

extension NewPostViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
}

// View
extension NewPostViewController {
    
    private func setButtons() {
        wineSelection.button.addTarget(self, action: #selector(showWineSelectionView), for: .touchUpInside)
    }
    
    private func configureView() {
        navigationItem.title = "새로운 포스트"
        let close = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(dismissView))
        navigationItem.leftBarButtonItem = close
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imagesCollectionView)
        contentView.addSubview(wineSelection)
        contentView.addSubview(titleField)
        contentView.addSubview(hashtagField)
        contentView.addSubview(contentsField)
        contentView.addSubview(postButton)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
         
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        imagesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(80)
        }
        
        wineSelection.snp.makeConstraints { make in
            make.top.equalTo(imagesCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(DesignSize.fieldHorizontalPadding)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        
        titleField.snp.makeConstraints { make in
            make.top.equalTo(wineSelection.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(DesignSize.fieldHorizontalPadding)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        
        hashtagField.snp.makeConstraints { make in
            make.top.equalTo(titleField.snp.bottom).offset(-DesignSize.outlineWidth)
            make.horizontalEdges.equalTo(contentView).inset(DesignSize.fieldHorizontalPadding)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        
        contentsField.snp.makeConstraints { make in
            make.top.equalTo(hashtagField.snp.bottom).offset(-DesignSize.outlineWidth)
            make.horizontalEdges.equalTo(contentView).inset(DesignSize.fieldHorizontalPadding)
            make.height.equalTo(200)
        }
        
        postButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.horizontalEdges.equalTo(contentView).inset(DesignSize.fieldHorizontalPadding)
            make.height.equalTo(50)
            make.top.equalTo(contentsField.snp.bottom).offset(30)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
    }
}
