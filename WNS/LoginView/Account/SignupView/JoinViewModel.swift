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
        
        let emailValid = input.email.map { email in
            guard !email.isEmpty else {
                self.validations[0] = ""
                return ValidationResult(valid: false)
            }
            let valid = self.isValidEmail(email: email)
            let info = valid ? "" : "[이메일] 이메일 형식을 맞춰주세요. ex) aaa@bbb.com"
            self.validations[0] = info
            return ValidationResult(valid: valid)
        }
        let passwordValid = input.password.map { password in
            guard !password.isEmpty else {
                self.validations[1] = ""
                return ValidationResult(valid: false)
            }
            let valid = password.count >= 8
            let info = valid ? "" : "[비밀번호] 8자리 이상 입력하세요."
            self.validations[1] = info
            return ValidationResult(valid: valid)
        }
        let nicknameValid = input.nickname.map { nickname in
            guard !nickname.isEmpty else {
                self.validations[2] = ""
                return ValidationResult(valid: false)
            }
            let valid = !nickname.contains(" ")
            let info = valid ? "" : "[닉네임] 공백없이 입력하세요"
            self.validations[2] = info
            return ValidationResult(valid: valid)
        }
        let ageValid = input.birthday.map { birthday in
            guard !birthday.isEmpty else {
                self.validations[3] = ""
                return ValidationResult(valid: false)
            }
            let validDate = self.isValidDate(birthday: birthday)
            let validAge = self.isValidAge(birthday: birthday)
            let info = validDate ? validAge ? "" : "[생일] 만 19세 이상만 가입 가능합니다." : "[생일] 생년월일 8자리를 입력하세요"
            self.validations[3] = info
            return ValidationResult(valid: validAge)
        }
        let phoneValid = input.phoneNumber.map { phone in
            guard !phone.isEmpty else {
                self.validations[4] = ""
                return ValidationResult(valid: true)
            }
            let countValid = phone.count >= 10
            let numValid = Int(phone) != nil
            let info = numValid ? countValid ? "" : "[전화번호] 10자리 이상 입력하세요." : "[전화번호] 숫자만 입력하세요."
            self.validations[4] = info
            return ValidationResult(valid: countValid && numValid)
        }
        let allValid = Observable.combineLatest(emailValid, passwordValid, nicknameValid, ageValid, phoneValid)
            .map { email, password, nickname, age, phone in
                email.valid && password.valid && nickname.valid && phone.valid && age.valid
            }
        let validationText = Observable
            .combineLatest(emailValid, passwordValid, nicknameValid, ageValid, phoneValid)
            .map { _ in
                return self.showWarnings(items: self.validations)
            }
            .startWith(self.showWarnings(items: self.validations))
        
        return Output(validationText: validationText,
                      allValidation: allValid,
                      tap: input.tap)
    }
}

extension JoinViewModel {
    
    struct ValidationResult {
        let valid: Bool
    }
    
    struct Input {
        let email: ControlProperty<String>
        let password: ControlProperty<String>
        let nickname: ControlProperty<String>
        let birthday: ControlProperty<String>
        let phoneNumber: ControlProperty<String>
        let tap: ControlEvent<Void>
        let emailDupCheck: ControlEvent<Void>
    }
    
    struct Output {
//        let emailValid: Observable<Bool>
        let validationText: Observable<String>
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
    
    private func isValidDate(birthday: String) -> Bool {
        guard birthday.count == 8 else { return false }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        guard let birthdate = dateFormatter.date(from: birthday) else {
            return false
        }
        
        return true
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
    
    private func showWarnings(items: [String]) -> String {
        let filteredItems = items
            .filter { !$0.isEmpty }
        let textToDisplay = filteredItems.joined(separator: "\n")
        return textToDisplay
    }
    
    
}
