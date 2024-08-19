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
    
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
//        let result = input.loginTap // dispose 되지 않고 계속 유지
//            .flatMap {
//                NetworkManager.shared.login(body: <#T##LoginBody#>, handler: { response in
//                    
//                }, failHandler: { message in
//                    
//                })
//                    .catch { error in
//                        return Single<Joke>.never()
//                    }
//            }
////            .catch { error in  // error일 때만
////                return Observable.just(Joke(joke: "Fail", id: 0))
////            }
////            .asSingle() // 1) 뷰에 결과가 안나옴, 2) 탭 이벤트 전달x, 3) 실패 - 탭 안됨. 통신만 oxox 되어야 하는데 탭 자체가 dispose됨
//            .asDriver(onErrorJustReturn: Joke(joke: "FAIL", id: 0))
//            .debug("Button Tap")
//        
        return Output()
    }
    
}

extension LoginViewModel {
    
    struct Input {
        let loginTap: ControlEvent<Void>
        let signupTap: ControlEvent<Void>
    }
    
    struct Output {
        
    }
}
