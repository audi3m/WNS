//
//  EditProfileViewController.swift
//  WNS
//
//  Created by J Oh on 9/2/24.
//
 
import UIKit
import SnapKit
import PhotosUI

final class EditProfileViewController: BaseViewController {
    
    lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    let nicknameField: OutlineField = {
        let view = OutlineField(fieldType: .nickname, cornerType: .all)
        view.textField.text = AccountManager.shared.nick
        return view
    }()
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        return button
    }()
    let progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .default)
        view.progressTintColor = .white
        view.backgroundColor = .black.withAlphaComponent(0.4)
        return view
    }()
    private var selectedImage: ImageItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

// Functions
extension EditProfileViewController {
    @objc private func editProfile() {
        progressView.isHidden = false
        var body = ProfileBody()
        
        if nicknameField.textField.text != AccountManager.shared.nick {
            body.nick = nicknameField.textField.text
        }
        
        if let selectedImage {
            body.profile = selectedImage.image.jpegData(compressionQuality: 0.1)
        } else {
            body.profile = UIImage(systemName: "person.circle")?.jpegData(compressionQuality: 1)
        }
        
        ProfileNetworkManager.shared.editProfile(body: body) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let success):
                print("SUCCESS")
                AccountManager.shared.userID = success.userID
                AccountManager.shared.nick = success.nick
                AccountManager.shared.profileImage = success.profileImage
                navigationController?.popViewController(animated: true)
            case .failure(let failure):
                print(failure)
                progressView.isHidden = true
            }
        }
    }
}

// PhotosUI
extension EditProfileViewController: PHPickerViewControllerDelegate {
    
    @objc private func openGallery() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        if let result = results.first {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
                guard let self else { return }
                if let image = object as? UIImage {
                    self.selectedImage = ImageItem(image: image)
                    DispatchQueue.main.async {
                        self.profileImageView.image = image
                    }
                }
            }
        }
    }
    
}

extension EditProfileViewController {
    private func configureView() {
        navigationItem.title = "프로필 수정"
        view.addSubview(profileImageView)
        view.addSubview(nicknameField)
        view.addSubview(doneButton)
        view.addSubview(progressView)
        progressView.isHidden = true
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(200)
        }
        nicknameField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(DesignSize.fieldHorizontalPadding)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.horizontalEdges.equalToSuperview().inset(DesignSize.fieldHorizontalPadding)
            make.height.equalTo(50)
        }
        progressView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileImageView.setImageWithURL(with: AccountManager.shared.profileImage)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openGallery))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(gesture)
        
    }
}
