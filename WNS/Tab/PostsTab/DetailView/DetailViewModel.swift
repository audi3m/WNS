//
//  DetailViewModel.swift
//  WNS
//
//  Created by J Oh on 8/17/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel {
    
    struct Input {
        let postID: String
        
        let likeTapped: () -> Void
        var inputLike: Bool
    }
    
    struct Output {
        
    }
    
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        
        
        return Output()
    }
    
}

extension DetailViewModel {
    
//    private func like() {
//        
//        like = !like
//        setLikeButton(like: like)
//        let body = LikeBody(like_status: like)
//        
//        LikeNetworkManager.shared.like(postID: postID, body: body) { response in
//            switch response {
//            case .success(let success):
//                DispatchQueue.main.async {
//                    let like = success.likeStatus
//                    self.setLikeButton(like: like)
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
    
}
