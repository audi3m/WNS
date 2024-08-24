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

final class NewPostViewController: BaseViewController {
    
    lazy private var imagesCollectionView: UICollectionView = {
        let view = UICollectionView(frame: view.bounds, collectionViewLayout: layout(size: CGSize(width: 80, height: 80)))
        view.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        view.showsHorizontalScrollIndicator = false
        view.register(PostImageCell.self, forCellWithReuseIdentifier: PostImageCell.id)
        view.register(GalleryButtonCell.self, forCellWithReuseIdentifier: GalleryButtonCell.id)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    private let titleTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "제목"
        field.borderStyle = .roundedRect
        return field
    }()
    private let hashtagTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "# 해시태그"
        field.borderStyle = .roundedRect
        return field
    }()
    private let contentTextView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 15)
        view.backgroundColor = .systemGray4
        return view
    }()
    lazy private var postButton: UIButton = {
        let button = UIButton()
        button.configuration = .borderedProminent()
        button.setTitle("업로드", for: .normal)
        button.addTarget(self, action: #selector(postButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let viewModel = NewPostViewModel()
    private var selectedImages = [ImageItem]()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
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
    
    struct ImageItem: Identifiable {
        let id = UUID()
        let image: UIImage
    }
}

// Button Functions
extension NewPostViewController {
    
    @objc private func postButtonClicked() {
        
//        let data = imageToData(images: selectedImages)
//        let postImageBody = PostImageBody(files: data)
//        NetworkManager.shared.postImage(body: postImageBody) { response in
//            print(response)
//        }
        
//        let postBody = PostBody(title: titleTextField.text,
//                                product_id: ProductID.forUsers.rawValue)
//        NetworkManager.shared.writePost(body: postBody) { [weak self] response in
//            dump(response)
//            // PorgressView
//            self?.dismissView()
//        }
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostImageCell.id, for: indexPath) as! PostImageCell
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
    
    private func configureView() {
        navigationItem.title = "새로운 포스트"
        let close = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(dismissView))
        navigationItem.leftBarButtonItem = close
        
        view.addSubview(imagesCollectionView)
        view.addSubview(titleTextField)
        view.addSubview(hashtagTextField)
        view.addSubview(contentTextView)
        view.addSubview(postButton)
        
        imagesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalTo(view)
            make.height.equalTo(80)
        }
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(imagesCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(44)
        }
        hashtagTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(44)
        }
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(hashtagTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(200)
        }
        postButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
    }
    
}
