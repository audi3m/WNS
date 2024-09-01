//
//  HashtagViewController.swift
//  WNS
//
//  Created by J Oh on 8/31/24.
//

import UIKit
import SnapKit
import TagListView

final class HashtagViewController: BaseViewController {
    
    lazy var hashField: OutlineField = {
        let view = OutlineField(fieldType: .hashtag, cornerType: .all)
        view.textField.placeholder = "공백 없이 입력 후 엔터"
        view.textField.delegate = self
        return view
    }()
    lazy var hashtagListView: CustomTagListView = {
        let view = CustomTagListView()
        view.textFont = UIFont.systemFont(ofSize: 18)
        view.tagBackgroundColor = .systemGray6
        view.textColor = .label
        view.cornerRadius = 8
        view.delegate = self
        return view
    }()
    lazy private var donButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = DesignSize.fieldCornerRadius
        button.setTitle("완료", for: .normal)
        button.addTarget(self, action: #selector(doneClicked), for: .touchUpInside)
        return button
    }()
    
    var sendHash: ((String) -> Void)?
    var hashtags: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setExistingHash()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let hash = getAllTagsText()
        sendHash?(hash)
    }
}

extension HashtagViewController: TagListViewDelegate {
    
    private func setExistingHash() {
        if let hashtags, !hashtags.isEmpty {
            let hashtagArray = hashtags.components(separatedBy: " ")
            for hash in hashtagArray {
                let _ = hashtagListView.addTag(hash)
            }
        }
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        sender.removeTagView(tagView)
    }
    
    @objc private func doneClicked() {
        navigationController?.popViewController(animated: true)
    }
}

extension HashtagViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let hash = hashField.textField.text else { return false }
        if !hash.isEmpty {
            
            let hashView = hashtagListView.addTag("#" + hash)
            hashField.textField.text = ""
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.contains(" ") ? false : true
    }
    
    func getAllTagsText() -> String {
        let allTagsArray = hashtagListView.tagViews.compactMap { $0.titleLabel?.text }
        return allTagsArray.joined(separator: " ")
    }
}

extension HashtagViewController {
    private func configureView() {
        navigationItem.title = "해시태그"
        
        view.addSubview(hashField)
        view.addSubview(hashtagListView)
        view.addSubview(donButton)
        
        hashField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(DesignSize.fieldHorizontalPadding)
            make.height.equalTo(50)
        }
        hashtagListView.snp.makeConstraints { make in
            make.top.equalTo(hashField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(DesignSize.fieldHorizontalPadding)
        }
        donButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.horizontalEdges.equalToSuperview().inset(DesignSize.fieldHorizontalPadding)
            make.height.equalTo(50)
        }
    }
}
