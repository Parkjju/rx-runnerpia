//
//  HomeViewModel.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/11.
//

import Foundation
import CoreLocation
import RxCocoa
import RxSwift

class HomeViewModel: ViewModelType {
    
    var bag = DisposeBag()
    
    struct Input {
        let viewDidLoad: Observable<Void>
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoad
            .subscribe(onNext: {
                LocationManager.shared.requestWhenInUseAuthorization()
                
                if LocationManager.getAuthorizationStatus() == .authorizedWhenInUse {
                    LocationManager.shared.startUpdatingLocation()
                }
            })
            .disposed(by: bag)
        
        return Output()
    }
}
