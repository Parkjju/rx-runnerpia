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
    
    // MARK: - Properties
    var viewModel: RouteRunningViewModel
    let marker = NMFMarker()
    let viewDidLoadTrigger = PublishSubject<Void>()
    
    // MARK: - Life Cycles
    init(viewModel: RouteRunningViewModel) {
        self.viewModel = viewModel
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
        view.addSubViews([mapView])
        
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        
        marker.position = NMGLatLng(lat: 0, lng: 0)
        marker.mapView = mapView
        marker.iconImage = NMFOverlayImage(image: ImageLiteral.imgCustomMarker)
    }
    
    override func bindViewModel() {
        let input = RouteRunningViewModel.Input(viewDidLoadTrigger: viewDidLoadTrigger, didChangeCoordinate: LocationManager.shared.rx.didUpdateLocations)
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
    }
}
