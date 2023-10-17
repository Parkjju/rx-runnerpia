//
//  RouteRegisterViewModel.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/13.
//

import Foundation
import RxCocoa
import RxSwift

class RouteRegisterViewModel: ViewModelType {
    
    struct Input {
        let secureTagSelected: Observable<SecureTagCell>
        let recommendedTagSelected: Observable<RecommendedTagCell>
    }
    
    struct Output {
        let secureTagCellItems: Driver<[SecureTagCellViewModel]>
        let recommendedTagCellItems: Driver<[RecommendedTagCellViewModel]>
    }
    
    func transform(input: Input) -> Output {
        let secureTagItems = BehaviorRelay<[SecureTagCellViewModel]>(value: [])
        let recommendedTagItems = BehaviorRelay<[RecommendedTagCellViewModel]>(value: [])
        
        secureTagItems.accept(SecureTags.retrieveAllSecureTagsWithArray()
            .map {
                SecureTagCellViewModel(with: $0)
            })
        
        recommendedTagItems.accept(RecommendTags.retrieveAllRecommendedTagsWithArray()
            .map {
                RecommendedTagCellViewModel(with: $0)
            })
        
        return Output(secureTagCellItems: secureTagItems.asDriver(), recommendedTagCellItems: recommendedTagItems.asDriver())
    }
}
