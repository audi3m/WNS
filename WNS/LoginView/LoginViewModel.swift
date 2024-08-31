//
//  LoginViewModel.swift
//  WNS
//
//  Created by J Oh on 8/17/24.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginViewModel {
    
    struct Input {
        let email: ControlProperty<String>
        let password: ControlProperty<String>
        let loginTap: ControlEvent<Void>
    }
    
    struct Output {
        let validationText: Observable<String>
        let allValidation: Observable<Bool>
        let tap: ControlEvent<Void>
    }
    
    let disposeBag = DisposeBag()
    var validations = ["", ""]
    
    func transform(input: Input) -> Output {
        
        let emailValid = input.email.map { email in
            guard !email.isEmpty else {
                self.validations[0] = ""
                return false
            }
            let valid = self.isValidEmail(email: email)
            let info = valid ? "" : "[이메일] 이메일 형식을 맞춰주세요. ex) aaa@bbb.com"
            self.validations[0] = info
            return valid
        }
        let passwordValid = input.password.map { password in
            guard !password.isEmpty else {
                self.validations[1] = ""
                return false
            }
            let valid = password.count >= 8
            let info = valid ? "" : "[비밀번호] 8자리 이상 입력하세요."
            self.validations[1] = info
            return valid
        }
        let allValid = Observable.combineLatest(emailValid, passwordValid)
            .map { emailValid, passwordValid in
                emailValid && passwordValid
            }
        let validationText = Observable
            .combineLatest(emailValid, passwordValid)
            .map { _ in
                return self.showWarnings(items: self.validations)
            }
            .startWith(self.showWarnings(items: self.validations))
        
        return Output(validationText: validationText,
                      allValidation: allValid,
                      tap: input.loginTap)
    }
    
}

extension LoginViewModel {
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func showWarnings(items: [String]) -> String {
        let filteredItems = items
            .filter { !$0.isEmpty }
        let textToDisplay = filteredItems.joined(separator: "\n")
        return textToDisplay
    }
   
}


