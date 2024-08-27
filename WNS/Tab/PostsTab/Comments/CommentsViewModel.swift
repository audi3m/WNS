//
//  CommentsViewModel.swift
//  WNS
//
//  Created by J Oh on 8/18/24.
//

import Foundation
import RxSwift
import RxCocoa

final class CommentsViewModel {
    
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        
    
        let result = Driver.just([Comment]())
        
        
        
        return Output(commentsList: result)
    }
    
}

extension CommentsViewModel {
    
    struct Input {
        let postID: PublishSubject<String>
        let refreshTap: ControlEvent<Void>
    }
    
    struct Output {
        let commentsList: Driver<[Comment]>
    }
}
