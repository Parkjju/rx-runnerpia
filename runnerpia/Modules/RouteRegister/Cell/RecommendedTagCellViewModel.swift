//
//  RecommendedTagViewModel.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/17.
//

import Foundation
import RxCocoa
import RxSwift

class RecommendedTagCellViewModel {
    let title = BehaviorRelay<String>(value: "")
    let isSelected = BehaviorRelay<Bool>(value: false)
    
    init(with recommendedTag: RecommendTags) {
        self.title.accept(recommendedTag.rawValue)
    }
}
