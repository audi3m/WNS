//
//  PaymentsViewController.swift
//  WNS
//
//  Created by J Oh on 9/8/24.
//

import UIKit
import SnapKit
import iamport_ios
import WebKit

final class PaymentsViewController: BaseViewController {
    
    private lazy var wkWebView: WKWebView = {
        var view = WKWebView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "결제 진행중..."
        label.font = .boldSystemFont(ofSize: 22)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    lazy var returnButton: UIButton = {
        let button = UIButton()
        button.setTitle("돌아가기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.configuration = .borderedProminent()
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        return button
    }()
    
    let payment: IamportPayment
    
    init(payment: IamportPayment) {
        self.payment = payment
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        showPayment()
    }
    
    @objc private func closeView() {
        dismissView()
    }
    
    private func showPayment() {
        Iamport.shared.paymentWebView(webViewMode: wkWebView, userCode: PaymentsConstants.userCode, payment: payment) { [weak self] iamportResponse in
            guard let self else { return }
            guard let iamportResponse else { return }
            
            switch iamportResponse.success {
            case true:
                dump(iamportResponse)
                self.resultLabel.text = "결제에 성공했습니다\n감사합니다"
                self.wkWebView.isHidden = true
                self.resultLabel.isHidden = false
                self.returnButton.isHidden = false
            case false:
                self.resultLabel.text = "결제에 실패했습니다\n다시 시도해 주세요"
                self.wkWebView.isHidden = true
                self.resultLabel.isHidden = false
                self.returnButton.isHidden = false
            default:
                print("Default")
            }
            
//            if let imp_uid = iamportResponse.imp_uid {
//                let body = PaymentBody(imp_uid: imp_uid, post_id: PaymentsConstants.postID)
//                PaymentManager.shared.checkPayments(body: body) { [weak self] response in
//                    guard let self else { return }
//                    switch response {
//                    case .success(let success):
//                        self.resultLabel.text = "감사합니다"
//                        self.wkWebView.isHidden = true
//                        self.resultLabel.isHidden = false
//                        self.returnButton.isHidden = false
//                        print(success)
//                    case .failure(let failure):
//                        self.resultLabel.text = "결제에 실패했습니다\n다시 시도해 주세요"
//                        self.wkWebView.isHidden = true
//                        self.resultLabel.isHidden = false
//                        self.returnButton.isHidden = false
//                        print(failure.localizedDescription)
//                    }
//                }
//            }
        }
    }
    
    private func configureView() {
        navigationItem.title = "결제 페이지"
        
        view.addSubview(wkWebView)
        view.addSubview(resultLabel)
        view.addSubview(returnButton)
        wkWebView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        resultLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        returnButton.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(20)
            make.centerX.equalTo(resultLabel)
//            make.width.equalTo(200)
//            make.height.equalTo(40)
        }
        resultLabel.isHidden = true
        returnButton.isHidden = true
    }
    
}

