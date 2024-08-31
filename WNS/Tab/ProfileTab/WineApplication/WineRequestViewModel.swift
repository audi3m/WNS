//
//  WineAddViewModel.swift
//  WNS
//
//  Created by J Oh on 8/30/24.
//

import Foundation
import RxSwift
import RxCocoa

final class WineRequestViewModel {
    
    struct Input {
        let name: ControlProperty<String>
        let variety: ControlProperty<String>
        let country: ControlProperty<String>
        let region: ControlProperty<String>
        let winery: ControlProperty<String>
    }
    
    struct Output {
        let validRequest: Observable<Bool>
    }
    
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let validRequest = Observable
            .combineLatest(input.name, input.variety, input.country, input.region, input.winery)
            .map { name, variety, country, region, winery in
                return !name.isEmpty && !variety.isEmpty && !country.isEmpty && !region.isEmpty && !winery.isEmpty
            }
            .share(replay: 1, scope: .whileConnected)
        
        return Output(validRequest: validRequest)
        
    }
    
}
 
