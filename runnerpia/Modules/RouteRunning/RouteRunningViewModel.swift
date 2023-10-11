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
        let viewDidLoadTrigger: Observable<Void>
        let didChangeCoordinate: Observable<[CLLocation]>
    }
    
    struct Output {
        let startPosition: BehaviorRelay<NMGLatLng?>
        let currentPosition: BehaviorRelay<NMGLatLng?>
    }
    
    func transform(input: Input) -> Output {
        let startPosition = BehaviorRelay<NMGLatLng?>(value: nil)
        let currentPosition = BehaviorRelay<NMGLatLng?>(value: nil)
        
        input.viewDidLoadTrigger
            .subscribe(onNext: {
                guard let coord = LocationManager.shared.location?.coordinate else { return }
                let nmg = NMGLatLng(lat: coord.latitude, lng: coord.longitude)
                startPosition.accept(nmg)
            })
            .disposed(by: bag)
        
        input.didChangeCoordinate
            .subscribe(onNext: {
                let nmg = NMGLatLng(lat: $0.last?.coordinate.latitude ?? 0, lng: $0.last?.coordinate.longitude ?? 0)
                currentPosition.accept(nmg)
            })
            .disposed(by: bag)
        
        return Output(startPosition: startPosition, currentPosition: currentPosition)
    }
}
