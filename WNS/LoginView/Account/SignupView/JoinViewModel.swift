//
//  JoinViewModel.swift
//  WNS
//
//  Created by J Oh on 8/15/24.
//

import Foundation
import RxSwift
import RxCocoa

final class JoinViewModel {
    
    let disposeBag = DisposeBag()
    var validations = ["", "", "", "", ""]
    
    func transform(input: Input) -> Output {
        let emailWarning = BehaviorRelay(value: "")
        let passwordWarning = BehaviorRelay(value: "")
        let phoneWarning = BehaviorRelay(value: "")
        let ageWarning = BehaviorRelay(value: "")
        
        let emailValidation = input.email.map { email in
            let valid = self.isValidEmail(email: email)
            let info = valid ? "" : "이메일 형식을 맞춰주세요. ex) aaa@bbb.com"
            return ValidationResult(valid: valid, text: info)
        }
        let passwordValidation = input.password.map { password in
            let valid = password.count >= 8
            let info = valid ? "" : "8자리 이상 입력하세요."
            return ValidationResult(valid: valid, text: info)
        }
        let nicknameValidation = input.password.map { nickname in
            let valid = !nickname.contains(" ")
            let info = valid ? "" : "공백없이 입력하세요"
            return ValidationResult(valid: valid, text: info)
        }
        let ageValidation = input.birthday.map { birthday in
            let valid = self.isValidAge(birthday: birthday)
            let info = valid ? "" : "만 19세 이상만 가입 가능합니다."
            return ValidationResult(valid: valid, text: info)
        }
        let phoneValidation = input.phoneNumber.map { phone in
            let countValid = phone.count >= 10
            let numValid = Int(phone) != nil
            let info = numValid ? countValid ? "유효한 전화번호입니다." : "10자리 이상 입력하세요." : "숫자만 입력하세요."
            return ValidationResult(valid: countValid && numValid, text: info)
        }
        let allValidation = Observable.combineLatest(emailValidation, passwordValidation, nicknameValidation, ageValidation, phoneValidation)
            .map { email, password, nickname, age, phone in
                email.valid && password.valid && nickname.valid && phone.valid && age.valid
            }
        
        return Output(emailValidation: emailValidation,
                      passwordValidation: passwordValidation,
                      nicknameValidation: nicknameValidation,
                      phoneValidation: phoneValidation,
                      ageValidation: ageValidation,
                      allValidation: allValidation,
                      tap: input.tap)
    }
}

extension JoinViewModel {
    
    struct ValidationResult {
        let valid: Bool
        let text: String
    }
    
    struct Input {
        let email: ControlProperty<String>
        let password: ControlProperty<String>
        let nickname: ControlProperty<String>
        let birthday: ControlProperty<String>
        let phoneNumber: ControlProperty<String>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let emailValidation: Observable<ValidationResult>
        let passwordValidation: Observable<ValidationResult>
        let nicknameValidation: Observable<ValidationResult>
        let phoneValidation: Observable<ValidationResult>
        let ageValidation: Observable<ValidationResult>
        let allValidation: Observable<Bool>
        let tap: ControlEvent<Void>
    }
}

extension JoinViewModel {
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidAge(birthday: String) -> Bool {
        guard birthday.count == 8 else { 
            return false
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        guard let birthdate = dateFormatter.date(from: birthday) else { 
            return false
        }
        
        let calendar = Calendar.current
        guard let over19 = calendar.date(byAdding: .year, value: -19, to: .now) else {
            return false
        }
        
        return birthdate <= over19
    }
    
    
     
}
