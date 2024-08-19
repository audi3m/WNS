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
        
        let dummyComments = [
            Comment(commentID: "1", content: "맛있어요", createdAt: "20240808", creater: Creater(userID: "IDID", nick: "Sesac", profileImage: "person")),
            Comment(commentID: "2", content: "별로에요", createdAt: "20240808", creater: Creater(userID: "IDID", nick: "Jack", profileImage: "person")),
            Comment(commentID: "3", content: "달아요", createdAt: "20240808", creater: Creater(userID: "IDID", nick: "Den", profileImage: "person")),
            Comment(commentID: "4", content: "과일향이 나요", createdAt: "20240808", creater: Creater(userID: "IDID", nick: "Bran", profileImage: "person")),
            Comment(commentID: "5", content: "스테이크랑 먹기 좋아요", createdAt: "20240808", creater: Creater(userID: "IDID", nick: "Hue", profileImage: "person"))
        ]
        
        let result = Driver.just(dummyComments)
        
        
        
        return Output(commentsList: result)
    }
    
}

extension CommentsViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        let commentsList: Driver<[Comment]>
    }
}
