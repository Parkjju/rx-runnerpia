//
//  SecureTagCellViewModel.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/17.
//

import Foundation
import RxCocoa
import RxSwift

class SecureTagCellViewModel {
    let title = BehaviorRelay<String>(value: "")
    
    init(with secureTag: SecureTags) {
        self.title.accept(secureTag.rawValue)
    }
}
