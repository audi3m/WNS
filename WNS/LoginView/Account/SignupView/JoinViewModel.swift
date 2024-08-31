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
    
    enum DupError: Error {
        case fillInBlank(message: String)
        case duplicated(message: String)
        case unknown
    }
    
    let disposeBag = DisposeBag()
    var validations = ["", "", "", "", ""]
    var isDuplicated = BehaviorRelay<Bool>(value: false)
    
    func transform(input: Input) -> Output {
        
        let emailValid = input.email.map { [weak self] email in
            guard let self else { return false }
            self.isDuplicated.accept(false)
            guard !email.isEmpty else {
                self.validations[0] = ""
                return false
            }
            let valid = self.isValidEmail(email: email)
            let info = valid ? "" : "[이메일] 이메일 형식을 맞춰주세요. ex) aaa@bbb.com"
            self.validations[0] = info
            return valid
        }
        let emailDuplicationChecked = input.emailDupTap
            .withLatestFrom(input.email)
            .flatMapLatest { [weak self] email -> Observable<Bool> in
                guard let self = self else { return .just(false) }
                return self.checkDuplication(email: email)
            }
            .do(onNext: { [weak self] isDuplicated in
                guard let self else { return }
                self.isDuplicated.accept(isDuplicated)
            })
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
        let nicknameValid = input.nickname.map { nickname in
            guard !nickname.isEmpty else {
                self.validations[2] = ""
                return false
            }
            let valid = !nickname.contains(" ")
            let info = valid ? "" : "[닉네임] 공백없이 입력하세요"
            self.validations[2] = info
            return valid
        }
        let ageValid = input.birthday.map { birthday in
            guard !birthday.isEmpty else {
                self.validations[3] = ""
                return false
            }
            let validDate = self.isValidDate(birthday: birthday)
            let validAge = self.isValidAge(birthday: birthday)
            let info = validDate ? validAge ? "" : "[생일] 만 19세 이상만 가입 가능합니다." : "[생일] 생년월일 8자리를 입력하세요"
            self.validations[3] = info
            return validAge
        }
        let allValid = Observable.combineLatest(emailValid, emailDuplicationChecked, passwordValid, nicknameValid, ageValid)
            .map { email, emailUnique, password, nickname, age in
                email && emailUnique && password && nickname && age
            }
        let validationText = Observable
            .combineLatest(emailValid, passwordValid, nicknameValid, ageValid)
            .map { _ in
                return self.showWarnings(items: self.validations)
            }
            .startWith(self.showWarnings(items: self.validations))
        
        return Output(validationText: validationText,
                      allValidation: allValid,
                      duplicationConfirmed: emailDuplicationChecked,
                      tap: input.tap)
    }
}

extension JoinViewModel {
    
    struct Input {
        let email: ControlProperty<String>
        let emailDuplicationTap: ControlEvent<Void>
        let password: ControlProperty<String>
        let nickname: ControlProperty<String>
        let birthday: ControlProperty<String>
        let tap: ControlEvent<Void>
        let emailDupTap: ControlEvent<Void>
    }
    
    struct Output {
        let validationText: Observable<String>
        let allValidation: Observable<Bool>
        let duplicationConfirmed: Observable<Bool>
        let tap: ControlEvent<Void>
    }
}

extension JoinViewModel {
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func checkDuplication(email: String) -> Observable<Bool> {
        return Observable.create { observer in
            let body = EmailDuplicationCheckBody(email: email)
            NetworkManager.shared.emailDuplicateCheck(body: body) { response in
                observer.onNext(true)
                observer.onCompleted()
            } onResponseError: { message in
                observer.onError(DupError.duplicated(message: message))
            }
            return Disposables.create()
        }
    }
    
    private func isValidDate(birthday: String) -> Bool {
        guard birthday.count == 8 else { return false }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        guard let _ = dateFormatter.date(from: birthday) else {
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
