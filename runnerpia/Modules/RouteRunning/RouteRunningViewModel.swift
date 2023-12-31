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
        let buttonTouchDownEvent: Observable<Void>
        let buttonTouchUpEvent: Observable<Void>
        let pauseButtonTapTrigger: Observable<Void>
        let playButtonTapTrigger: Observable<Void>
        let stopButtonTouchDownEvent: Observable<Void>
        let stopButtonTouchUpEvent: Observable<Void>
    }
    
    struct Output {
        let startPosition: BehaviorRelay<NMGLatLng?>
        let currentPosition: BehaviorRelay<NMGLatLng?>
        let isRecordStarted: Driver<Bool>
        let isRecordPaused: Driver<Bool?>
        let runningTime: Driver<Int>
        let runningDistance: Driver<Int>
        let isRecordStop: Driver<Bool>
        let recordingCoordinates: Driver<[NMGLatLng]>
    }
    
    func transform(input: Input) -> Output {
        let startPosition = BehaviorRelay<NMGLatLng?>(value: nil)
        let currentPosition = BehaviorRelay<NMGLatLng?>(value: nil)
        let recordStartTrigger = BehaviorRelay<Bool>(value: false)
        let isRecordPaused = BehaviorRelay<Bool?>(value: nil)
        let runningTime = BehaviorRelay<Int>(value: 0)
        let lastCoordinate = BehaviorRelay<CLLocation?>(value: nil)
        let distance = BehaviorRelay<Int>(value: 0)
        let isRecordStop = BehaviorRelay<Bool>(value: false)
        let recordingCoordinates = BehaviorRelay<[NMGLatLng]>(value: [])
        
        
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
        
        input.buttonTouchDownEvent
            .flatMapLatest {
                Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).take(until: input.buttonTouchUpEvent)
            }
            .subscribe(onNext: { second in
                if second > 0  {
                    recordStartTrigger.accept(true)
                    isRecordPaused.accept(false)
                } else {
                    recordStartTrigger.accept(false)
                }
                
            })
            .disposed(by: bag)
        
        input.pauseButtonTapTrigger
            .subscribe(onNext: {
                isRecordPaused.accept(true)
            })
            .disposed(by: bag)
        
        input.playButtonTapTrigger
            .subscribe(onNext: {
                isRecordPaused.accept(false)
            })
            .disposed(by: bag)
        
        isRecordPaused.asObservable()
            .flatMapLatest { isPaused -> Observable<Int> in
                guard let isPaused = isPaused else { return Observable<Int>.empty() }
                return !isPaused ? Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance) : Observable<Int>.empty()
            }
            .subscribe(onNext: { _ in
                runningTime.accept(runningTime.value + 1)
            })
            .disposed(by: bag)
        
        isRecordPaused.asObservable()
            .flatMapLatest { isPaused -> Observable<[CLLocation]> in
                guard let isPaused = isPaused else { return Observable<[CLLocation]>.empty() }
                if isPaused {
                    return Observable<[CLLocation]>.empty()
                } else {
                    return LocationManager.shared.rx.didUpdateLocations
                }
            }
            .subscribe(onNext: {
                guard let currentLocation = $0.last,
                      let coordinate = lastCoordinate.value else {
                    lastCoordinate.accept($0.last)
                    return
                }
                distance.accept(distance.value + Int(currentLocation.distance(from: coordinate)))
                lastCoordinate.accept(currentLocation)
                
                let nmg = NMGLatLng(lat: currentLocation.coordinate.latitude, lng: currentLocation.coordinate.longitude)
                recordingCoordinates.accept(recordingCoordinates.value + [nmg])
            })
            .disposed(by: bag)
        
        input.stopButtonTouchDownEvent
            .flatMapLatest {
                Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).take(until: input.stopButtonTouchUpEvent)
            }
            .subscribe(onNext: { second in
                if second > 0 && second <= 1 {
                    isRecordStop.accept(true)
                } else {
                    isRecordStop.accept(false)
                }
                
            })
            .disposed(by: bag)


        
        return Output(startPosition: startPosition, currentPosition: currentPosition, isRecordStarted: recordStartTrigger.asDriver(), isRecordPaused: isRecordPaused.asDriver(), runningTime: runningTime.asDriver(), runningDistance: distance.asDriver(), isRecordStop: isRecordStop.asDriver(), recordingCoordinates: recordingCoordinates.asDriver())
    }
}
