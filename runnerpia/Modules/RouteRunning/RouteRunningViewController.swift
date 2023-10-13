//
//  RouteRunningViewController.swift
//  runnerpia
//
//  Created by Jun on 2023/10/10.
//

import UIKit
import CoreLocation
import NMapsMap
import RxSwift

class RouteRunningViewController: BaseViewController {
    
    // MARK: - Subviews
    let mapView = NMFMapView()
    
    let recordSectionView = RecordSectionView()
    
    // MARK: - Properties
    var viewModel: RouteRunningViewModel
    let marker = NMFMarker()
    let viewDidLoadTrigger = PublishSubject<Void>()
    let polyline = NMFPolylineOverlay([])
    var homeFlow: HomeFlow
    
    // MARK: - Life Cycles
    init(viewModel: RouteRunningViewModel, homeFlow: HomeFlow) {
        self.viewModel = viewModel
        self.homeFlow = homeFlow
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadTrigger.onNext(())
    }
    
    // MARK: - Functions
    
    override func render() {
        view.addSubViews([mapView, recordSectionView])
        
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        recordSectionView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(self.view)
            make.height.equalTo(210)
        }
    }
    
    override func configUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "송정뚝방길"
        
        marker.position = NMGLatLng(lat: 0, lng: 0)
        marker.mapView = mapView
        marker.iconImage = NMFOverlayImage(image: ImageLiteral.imgCustomMarker)
        
        polyline?.mapView = mapView
    }
    
    override func bindViewModel() {
        let input = RouteRunningViewModel.Input(viewDidLoadTrigger: viewDidLoadTrigger, didChangeCoordinate: LocationManager.shared.rx.didUpdateLocations, buttonTouchDownEvent: recordSectionView.recordTriggerButton.rx.controlEvent(.touchDown).asObservable(), buttonTouchUpEvent: recordSectionView.recordTriggerButton.rx.controlEvent(.touchUpInside).asObservable(), pauseButtonTapTrigger: recordSectionView.pauseButton.rx.controlEvent(.touchUpInside).asObservable(), playButtonTapTrigger: recordSectionView.playButton.rx.controlEvent(.touchUpInside).asObservable(), stopButtonTouchDownEvent: recordSectionView.stopButton.rx.controlEvent(.touchDown).asObservable(), stopButtonTouchUpEvent: recordSectionView.stopButton.rx.controlEvent(.touchUpInside).asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.startPosition
            .subscribe(onNext: { [unowned self] in
                guard let coord = $0 else { return }
                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: coord.lat, lng: coord.lng))
                self.mapView.moveCamera(cameraUpdate)
                self.marker.position = coord
            })
            .disposed(by: disposeBag)
        
        output.currentPosition
            .subscribe(onNext: { [unowned self] in
                guard let coord = $0 else { return }
                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: coord.lat, lng: coord.lng))
                self.mapView.moveCamera(cameraUpdate)
                self.marker.position = coord
            })
            .disposed(by: disposeBag)
        
        output.isRecordStarted
            .drive(onNext: { [unowned self] in
                if $0 {
                    self.sectionViewHiddenController(isHidden: true)
                    UIView.animate(withDuration: 0.3) {
                        self.recordSectionView.snp.updateConstraints { make in
                            make.height.equalTo(260)
                        }
                        self.view.layoutIfNeeded()
                    }
                } else {
                    self.sectionViewHiddenController(isHidden: false)
                }
            })
            .disposed(by: disposeBag)
        
        output.isRecordPaused
            .drive(onNext: { [unowned self] in
                guard let isHidden = $0 else { return }
                self.sectionViewButtonHiddenController(isHidden: isHidden)
            })
            .disposed(by: disposeBag)
        
        output.runningTime
            .drive(onNext: { [unowned self] in
                let seconds = $0 % 60 < 10 ? "0\($0 % 60)" : "\($0 % 60)"
                let minutes = $0 / 60 < 10 ? "0\($0 / 60)" : "\($0 / 60)"
                self.recordSectionView.timeLabel.text = "\(minutes):\(seconds)"
            })
            .disposed(by: disposeBag)
        
        output.runningDistance
            .drive(onNext: { [unowned self] in
                let kilometer = $0 / 1000
                let meter = ($0 % 1000) / 10 < 10 ? "0\(($0 % 1000) / 10)" : "\(($0 % 1000) / 10)"
                self.recordSectionView.distanceLabel.text = "\(kilometer).\(meter)km"
            })
            .disposed(by: disposeBag)
        
        output.isRecordStop
            .drive(onNext: { [unowned self] in
                if $0 {
                    let alert = UIAlertController(title: "경로 기록을 종료할까요?", message: nil, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "확인", style: .default, handler: { _ in
                        self.homeFlow.push(scene: .runningComplete)
                    })
                    let cancelAction = UIAlertAction(title: "취소", style: .cancel)
                    alert.addAction(okAction)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func sectionViewHiddenController(isHidden: Bool) {
        self.recordSectionView.recordTriggerButton.isHidden = isHidden
        self.recordSectionView.pauseButton.isHidden = !isHidden
        self.recordSectionView.defaultLabel.isHidden = isHidden
        self.recordSectionView.timeLabel.isHidden = !isHidden
        self.recordSectionView.timeSubLabel.isHidden = !isHidden
        self.recordSectionView.distanceLabel.isHidden = !isHidden
        self.recordSectionView.distanceSubLabel.isHidden = !isHidden
    }
    
    func sectionViewButtonHiddenController(isHidden: Bool) {
        self.recordSectionView.playButton.isHidden = !isHidden
        self.recordSectionView.stopButton.isHidden = !isHidden
        self.recordSectionView.pauseButton.isHidden = isHidden
    }
     
}
