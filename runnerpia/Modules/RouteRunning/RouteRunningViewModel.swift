//
//  RouteRunningViewModel.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/11.
//

import Foundation
import NMapsMap
import RxCocoa
import RxSwift

class RouteRunningViewModel: ViewModelType {
    var bag = DisposeBag()
    
    struct Input {
        let didChangeCoordinate: Observable<Coordinate>
    }
    
    struct Output {
        let currentPosition: BehaviorRelay<NMGLatLng?>
    }
    
    func transform(input: Input) -> Output {
        let currentPosition = BehaviorRelay<NMGLatLng?>(value: nil)
        
        input.didChangeCoordinate
            .subscribe(onNext: {
                let nmg = NMGLatLng(lat: $0.latitude, lng: $0.longitude)
                currentPosition.accept(nmg)
            })
            .disposed(by: bag)
        
        return Output(currentPosition: currentPosition)
    }
}
