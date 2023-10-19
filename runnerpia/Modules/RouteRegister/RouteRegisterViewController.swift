//
//  RouteFollowingViewController.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/10.
//

import UIKit
import NMapsMap

/// 신 경로 등록 뷰
class RouteRegisterViewController: BaseViewController {
    
    // MARK: - Subviews
    
    let scrollView = UIScrollView()
        .then { sv in
            let view = UIView()
            sv.addSubview(view)
            view.snp.makeConstraints {
                $0.top.equalTo(sv.contentLayoutGuide.snp.top)
                $0.leading.equalTo(sv.contentLayoutGuide.snp.leading)
                $0.trailing.equalTo(sv.contentLayoutGuide.snp.trailing)
                $0.bottom.equalTo(sv.contentLayoutGuide.snp.bottom)

                $0.leading.equalTo(sv.frameLayoutGuide.snp.leading)
                $0.trailing.equalTo(sv.frameLayoutGuide.snp.trailing)
                $0.height.equalTo(sv.frameLayoutGuide.snp.height).priority(.low)
            }
        }
    
    let mapView = NMFMapView()
        .then {
            $0.layer.cornerRadius = 10 // MARK: mapView Radius -> 10
            $0.allowsScrolling = false
            $0.allowsRotating = false
            $0.allowsZooming = false
            $0.allowsTilting = false
        }
    
    let routeNameLabel = UILabel()
        .then {
            $0.font = .pretendard(.semibold, ofSize: 18)
            $0.text = "러닝 경로 이름"
        }
    
    let routeNameTextView = UITextField()
        .then {
            $0.layer.borderColor = UIColor.grey300.cgColor
            $0.layer.borderWidth = 1
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
            $0.font = .pretendard(.semibold, ofSize: 18)
            $0.setLeftPaddingPoints(16)
            $0.placeholder = "송정뚝방길 02"
        }
    
    let routeInformationLabel = UILabel()
        .then {
            $0.font = .pretendard(.semibold, ofSize: 18)
            $0.text = "경로 정보"
        }
    
    let routeInformationView = RouteInformation()
    
    let dividerUnderRouteInfo = UIImageView(image: ImageLiteral.imgDivider)
    
    // MARK: - Properties
    var viewModel: RouteRegisterViewModel
    var homeFlow: HomeFlow
    
    // MARK: - Initialization
    
    init(viewModel: RouteRegisterViewModel, homeFlow: HomeFlow) {
        self.viewModel = viewModel
        self.homeFlow = homeFlow
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles
    
    // MARK: - Functions
    
    override func render() {
        view.addSubview(scrollView)
        
        scrollView.subviews.first!.addSubViews([mapView, routeNameLabel, routeNameTextView, routeInformationLabel, routeInformationView, dividerUnderRouteInfo])
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.trailing.leading.equalTo(view)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.subviews.first!)
            make.leading.trailing.equalTo(view).inset(16)
            make.height.equalTo(180)
        }
        
        routeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.leading.equalTo(mapView)
        }
        
        routeNameTextView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(mapView)
            make.top.equalTo(routeNameLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
        
        routeInformationLabel.snp.makeConstraints { make in
            make.leading.equalTo(mapView)
            make.top.equalTo(routeNameTextView.snp.bottom).offset(20)
        }
        
        routeInformationView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(mapView)
            make.height.equalTo(116)
            make.top.equalTo(routeInformationLabel.snp.bottom).offset(20)
        }
        
        dividerUnderRouteInfo.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.trailing.equalTo(mapView)
        }
        
        
    }
    
    override func configUI() {
        self.navigationItem.title = "추천 경로 등록"
        view.backgroundColor = .white
    }
}
