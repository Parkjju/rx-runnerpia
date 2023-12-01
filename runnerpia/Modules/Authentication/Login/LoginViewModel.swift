//
//  LoginViewModel.swift
//  runnerpia
//
//  Created by 박경준 on 12/1/23.
//

import Foundation
import RxCocoa
import RxSwift

class LoginViewModel: ViewModelType {
    
    var apiSession: APIService = APISession()
    var disposeBag = DisposeBag()
    
    struct Input {
        let userId: Observable<String>
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
}
