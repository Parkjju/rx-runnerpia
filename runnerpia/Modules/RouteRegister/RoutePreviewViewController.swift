//
//  RoutePreviewViewController.swift
//  runnerpia
//
//  Created by Jun on 2023/10/18.
//

import UIKit
import NMapsMap

class RoutePreviewViewController: BaseViewController {
    
    // MARK: - Subviews
    
    let mapView = NMFMapView()
        .then {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
            $0.allowsScrolling = false
            $0.allowsRotating = false
            $0.allowsZooming = false
            $0.allowsTilting = false
        }
    
    let completeLabel = UILabel()
        .then {
            $0.font = UIFont.boldSystemFont(ofSize: 24)
            $0.numberOfLines = 0
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            
            let runningTitleText = NSMutableAttributedString(string: "12월 31일,\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .semibold, width: .standard), NSAttributedString.Key.paragraphStyle: paragraphStyle])
            
            let text = NSMutableAttributedString(string: "러닝을 완료", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .semibold, width: .standard), NSAttributedString.Key.foregroundColor: UIColor.blue400])
            
            let remainText = NSMutableAttributedString(string: "했어요!", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .semibold, width: .standard)])
            
            runningTitleText.append(text)
            runningTitleText.append(remainText)
            
            $0.attributedText = runningTitleText
        }
    
    let routeInformationView = RouteInformation()
    
    let nextButton = UIButton(type: .system)
        .then {
            $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
            $0.titleLabel?.font = .pretendard(.semibold, ofSize: 16)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 20 // MARK: Button Radius -> 20
            $0.setTitleColor(.white, for: .normal)
            $0.setTitle("경로 등록하기", for: .normal)
            $0.backgroundColor = .blue400
        }
    
    
    
    // MARK: - Properties
    var viewModel: RouteRegisterViewModel
    var homeFlow: HomeFlow
    
    // MARK: - Life Cycles
    
    // MARK: - Initialization
    
    init(viewModel: RouteRegisterViewModel, homeFlow: HomeFlow) {
        self.viewModel = viewModel
        self.homeFlow = homeFlow
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    override func render() {
        view.addSubViews([mapView, completeLabel, routeInformationView, nextButton])
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).offset(-16)
            make.height.equalTo(UIScreen.main.bounds.height * 0.4)
        }
        
        completeLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.leading.equalTo(mapView)
        }
        
        routeInformationView.snp.makeConstraints { make in
            make.top.equalTo(completeLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(mapView)
            make.height.equalTo(116)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-6)
            make.height.equalTo(54)
            make.leading.trailing.equalTo(mapView)
        }
    }
    
    override func configUI() {
        view.backgroundColor = .white
        navigationItem.title = "러닝 내역"
        
        let rightBarButtonItem = UIBarButtonItem(image: ImageLiteral.imgClose.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    // MARK: - Objc Functions
    @objc
    func closeButtonTapped() {
        homeFlow.popToRootView()
    }
    
    @objc
    func nextButtonTapped() {
        homeFlow.push(scene: .inputPathInfo)
    }
}
