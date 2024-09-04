//
//  InquiryViewController.swift
//  WNS
//
//  Created by J Oh on 8/30/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class InquiryViewController: BaseViewController {
    
    let titleField = OutlineField(fieldType: .title, cornerType: .top)
    let contentsField = OutlineField(fieldType: .contents, cornerType: .bottom)
    let validationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemRed
        return label
    }()
    lazy private var submitButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = DesignSize.fieldCornerRadius
        button.backgroundColor = .lightGray
        button.setTitle("제출", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(submitInquiry), for: .touchUpInside)
        return button
    }()
    
    let viewModel = InquiryViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureView()
        rxBind()
    }
}

// rx
extension InquiryViewController {
    private func rxBind() {
        let input = InquiryViewModel.Input(title: titleField.textField.rx.text.orEmpty,
                                           contents: contentsField.textView.rx.text.orEmpty)
        let output = viewModel.transform(input: input)
         
        output.validInquiry
            .observe(on: MainScheduler.instance)
            .bind(with: self) { owner, valid in
                owner.submitButton.isEnabled = valid
                owner.submitButton.backgroundColor = valid ? .systemBlue : .lightGray
                owner.validationLabel.text = valid ? "" : "제목과 내용을 모두 입력해주세요"
            }
            .disposed(by: disposeBag)
        
    }
}

extension InquiryViewController {
    @objc private func submitInquiry() {
        print(#function)
        let body = PostBody(content1: titleField.textField.text,
                            content2: contentsField.textView.text,
                            product_id: ProductID.forInquiry.rawValue)
        NetworkManager.shared.writePost(body: body) { post in
            dump(post)
            self.showAlert(title: "", message: "제출되었습니다", ok: "확인") {
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
}

extension InquiryViewController {
    
    private func configureNavBar() {
        navigationItem.title = "1:1 문의"
        let close = UIBarButtonItem(title: "닫기", image: nil, target: self, action: #selector(dismissView))
        navigationItem.leftBarButtonItem = close
    }
    
    private func configureView() {
        view.addSubview(titleField)
        view.addSubview(contentsField)
        view.addSubview(validationLabel)
        view.addSubview(submitButton)
        
        titleField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(DesignSize.fieldHorizontalPadding)
            make.height.equalTo(50)
        }
        
        contentsField.snp.makeConstraints { make in
            make.top.equalTo(titleField.snp.bottom).offset(-DesignSize.outlineWidth)
            make.horizontalEdges.equalToSuperview().inset(DesignSize.fieldHorizontalPadding)
            make.height.equalTo(200)
        }
        
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(contentsField.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(DesignSize.fieldHorizontalPadding)
        }
        
        submitButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.horizontalEdges.equalToSuperview().inset(DesignSize.fieldHorizontalPadding)
            make.height.equalTo(50)
            
        }
    }
}
