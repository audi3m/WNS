//
//  InquiryViewModel.swift
//  WNS
//
//  Created by J Oh on 8/30/24.
//

import Foundation
import RxSwift
import RxCocoa

final class InquiryViewModel {
    
    struct Input {
        let title: ControlProperty<String>
        let contents: ControlProperty<String>
    }
    
    struct Output {
        let validInquiry: Observable<Bool>
    }
    
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let validInquiry = Observable
            .combineLatest(input.title, input.contents)
            .map { title, contents in
                return !title.isEmpty && !contents.isEmpty
            }
            .share(replay: 1, scope: .whileConnected)
        
        return Output(validInquiry: validInquiry)
        
    }
    
}
 
