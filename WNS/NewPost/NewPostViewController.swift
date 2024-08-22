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
    
    let placeHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    private lazy var galleryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.addTarget(self, action: #selector(openGallery), for: .touchUpInside)
        return button
    }()
    let titleTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "제목"
        field.borderStyle = .roundedRect
        return field
    }()
    let hashtagTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "# 해시태그"
        field.borderStyle = .roundedRect
        return field
    }()
    let contentTextView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 15)
        view.backgroundColor = .systemGray4
        return view
    }()
    lazy var postButton: UIButton = {
        let button = UIButton()
        button.configuration = .borderedProminent()
        button.setTitle("업로드", for: .normal)
        button.addTarget(self, action: #selector(postButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let viewModel = NewPostViewModel()
    private var selectedImageViews: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        configureView()
        rxBind()
    }
    
    
    
}

// Rx
extension NewPostViewController {
    
    private func rxBind() {
        
        let input = NewPostViewModel.Input()
        let output = viewModel.transform(input: input)
        
    }
    
}

// PhotosUI
extension NewPostViewController: PHPickerViewControllerDelegate {
    
    @objc private func openGallery() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 5
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        selectedImageViews = []
        
        for (index, result) in results.enumerated() {
            guard index < 5 else { break }
            
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.selectedImageViews[index].image = image
                    }
                }
            }
        }
    }
}

// Button Functions
extension NewPostViewController {
    
    
    @objc private func postButtonClicked() {
        
//        let postImageBody = PostImageBody(files: Data())
//        NetworkManager.shared.postImage(body: postImageBody)
        
        let postBody = PostBody(title: titleTextField.text,
                                product_id: ProductID.forUsers.rawValue)
        NetworkManager.shared.writePost(body: postBody) { [weak self] response in
            dump(response)
            // PorgressView
            
            self?.dismissView()
        }
        
        
    }
    
    @objc private func dismissView() {
        dismiss(animated: true)
    }
    
}


extension NewPostViewController {
    private func setNavBar() {
        navigationItem.title = "새로운 포스트"
        let close = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(dismissView))
        navigationItem.leftBarButtonItem = close
        
    }
}

// View
extension NewPostViewController {
    
    private func configureView() {
        
        view.addSubview(placeHolderView)
        view.addSubview(titleTextField)
        view.addSubview(hashtagTextField)
        view.addSubview(contentTextView)
        view.addSubview(postButton)
        
        placeHolderView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view)
            make.height.equalTo(100)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(placeHolderView.snp.bottom).offset(20)
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
