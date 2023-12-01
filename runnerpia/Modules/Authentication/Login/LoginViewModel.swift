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
        let userId: Observable<String?>
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        
        /// 1. 유저 아이디값 세팅
        input.userId
            .compactMap { $0 }
            .flatMapLatest { [unowned self] userId -> Observable<String> in
                return self.apiSession.requestSingle(.login(userId: userId)).asObservable()
            }
            .subscribe(onNext: {
                print("RESULT: \($0)")
            })
            .disposed(by: disposeBag)
        
        return Output()
    }
}
