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
     
    let wineSelection = OutlineNavigation(placeholer: "와인선택", image: "wineglass", cornerType: .top)
    let hashtagField = OutlineNavigation(placeholer: "해시태그", lines: 0, image: "number", cornerType: .bottom)
    let contentsField = OutlineField(fieldType: .contents, cornerType: .all)
    
    lazy private var postButton: UIButton = {
        let button = UIButton()
        button.configuration = .borderedProminent()
        button.setTitle("업로드", for: .normal)
        button.addTarget(self, action: #selector(postButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let viewModel = NewPostViewModel()
    private var selectedImages = [ImageItem]()
    var selectedWine: Wine?
    var hashList: String = ""
     
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
    
    @objc private func showHashtagClicked() {
        let vc = HashtagViewController()
        vc.hashtags = self.hashList
        vc.sendHash = { [weak self] hash in
            guard let self else { return }
            self.hashList = hash
            self.hashtagField.fieldLabel.text = hashList
            self.hashtagField.fieldLabel.textColor = .systemBlue
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func showWineSelectionView() {
        let vc = WineSelectViewController()
        vc.sendSelectedWine = { [weak self] wine in
            guard let self else { return }
            self.selectedWine = wine
            self.wineSelection.fieldLabel.text = wine.name
            self.wineSelection.fieldLabel.textColor = .label
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func postButtonClicked() {
        guard let selectedWine else { return }
        guard let wineString = selectedWine.toJsonString() else { return }
        let hashtag = selectedWine.nameForHashtag + " " + hashList
        
        let body = LoginBody(email: AccountManager.shared.email, password: AccountManager.shared.password)
        AccountNetworkManager.shared.login(body: body) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let success):
                self.postButton.isEnabled = false
                print("login success")
                
                PostNetworkManager.shared.postImages(items: self.selectedImages) { [weak self] response in
                    guard let self else { return }
                    switch response {
                    case .success(let success):
                        let body = PostBody(title: "",
                                            content: hashtag,
                                            content1: wineString,
                                            content2: self.contentsField.textView.text,
                                            product_id: ProductID.forUsers.rawValue,
                                            files: success.files)
                        // 게시글 작성 요청
                        PostNetworkManager.shared.writePost(body: body) { [weak self] post in
                            guard let self else { return }
                            print(post)
                            self.dismissView()
                        }
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                }
            case .failure(let failure):
                print(failure.localizedDescription)
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
        wineSelection.navigateButton.addTarget(self, action: #selector(showWineSelectionView), for: .touchUpInside)
        hashtagField.navigateButton.addTarget(self, action: #selector(showHashtagClicked), for: .touchUpInside)
    }
    
    private func configureView() {
        navigationItem.title = "새로운 포스트"
        let close = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(dismissView))
        navigationItem.leftBarButtonItem = close
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imagesCollectionView)
        contentView.addSubview(wineSelection)
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
        
        hashtagField.snp.makeConstraints { make in
            make.top.equalTo(wineSelection.snp.bottom).offset(-DesignSize.outlineWidth)
            make.horizontalEdges.equalTo(contentView).inset(DesignSize.fieldHorizontalPadding)
            make.height.greaterThanOrEqualTo(DesignSize.fieldHeight)
        }
        
        contentsField.snp.makeConstraints { make in
            make.top.equalTo(hashtagField.snp.bottom).offset(20)
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
