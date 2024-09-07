//
//  WineRequestViewController.swift
//  WNS
//
//  Created by J Oh on 8/29/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class WineRequestViewController: BaseViewController {
    
    // 이름, 품종, 국가, 지역, 와이너리
    let nameField = OutlineField(fieldType: .wineName, cornerType: .top)
    let grapeField = OutlineField(fieldType: .variety, cornerType: .middle)
    let countryField = OutlineField(fieldType: .country, cornerType: .middle)
    let regionField = OutlineField(fieldType: .region, cornerType: .middle)
    let wineryField = OutlineField(fieldType: .winery, cornerType: .bottom)
    let validationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemRed
        return label
    }()
    lazy private var submitButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = DesignSize.fieldCornerRadius
        button.backgroundColor = .systemBlue
        button.setTitle("신청", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
        return button
    }()
    
    let viewModel = WineRequestViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureView()
        rxBind()
    }
}

// rx
extension WineRequestViewController {
    private func rxBind() {
        let input = WineRequestViewModel.Input(name: nameField.textField.rx.text.orEmpty,
                                               variety: grapeField.textField.rx.text.orEmpty,
                                               country: countryField.textField.rx.text.orEmpty,
                                               region: regionField.textField.rx.text.orEmpty,
                                               winery: wineryField.textField.rx.text.orEmpty)
        let output = viewModel.transform(input: input)
        
        output.validRequest
            .observe(on: MainScheduler.instance)
            .bind(with: self) { owner, valid in
                owner.submitButton.isEnabled = valid
                owner.submitButton.backgroundColor = valid ? .systemBlue : .lightGray
                owner.validationLabel.text = valid ? "" : "모든 정보를 입력해주세요"
            }
            .disposed(by: disposeBag)
        
    }
}

extension WineRequestViewController {
    @objc private func submit() {
        print(#function)
        let body = PostBody(title: "",
                            content: "",
                            content1: nameField.textField.text,
                            content2: grapeField.textField.text,
                            content3: countryField.textField.text,
                            content4: regionField.textField.text,
                            content5: wineryField.textField.text,
                            product_id: ProductID.forWineRequest.rawValue)
        PostNetworkManager.shared.writePost(body: body) { post in
            self.showAlert(title: "", message: "제출되었습니다", ok: "확인") {
                dump(post)
                self.dismissView()
            }
        }
    }
}

extension WineRequestViewController {
    
    private func configureNavBar() {
        let close = UIBarButtonItem(title: "닫기", image: nil, target: self, action: #selector(dismissView))
        navigationItem.leftBarButtonItem = close
    }
    
    private func configureView() {
        navigationItem.title = "와인 추가 요청"
        
        view.addSubview(nameField)
        view.addSubview(grapeField)
        view.addSubview(countryField)
        view.addSubview(regionField)
        view.addSubview(wineryField)
        view.addSubview(validationLabel)
        view.addSubview(submitButton)
        
        nameField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view).inset(30)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        grapeField.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(-DesignSize.outlineWidth)
            make.horizontalEdges.equalTo(view).inset(30)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        countryField.snp.makeConstraints { make in
            make.top.equalTo(grapeField.snp.bottom).offset(-DesignSize.outlineWidth)
            make.horizontalEdges.equalTo(view).inset(30)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        regionField.snp.makeConstraints { make in
            make.top.equalTo(countryField.snp.bottom).offset(-DesignSize.outlineWidth)
            make.horizontalEdges.equalTo(view).inset(30)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        wineryField.snp.makeConstraints { make in
            make.top.equalTo(regionField.snp.bottom).offset(-DesignSize.outlineWidth)
            make.horizontalEdges.equalTo(view).inset(30)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(wineryField.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(DesignSize.fieldHorizontalPadding)
        }
        submitButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.horizontalEdges.equalToSuperview().inset(DesignSize.fieldHorizontalPadding)
            make.height.equalTo(50)
        }
        
        nameField.iconImageView.tintColor = .label
        countryField.iconImageView.tintColor = .label
        regionField.iconImageView.tintColor = .label
        
    }
    
}
