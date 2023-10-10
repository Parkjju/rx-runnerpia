//
//  HomeViewController.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/10.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - Subviews
    private let appTitle = UILabel()
        .then {
            $0.font = .pretendard(.bold, ofSize: 16)
            $0.textColor = .blue400
            $0.text = "Runnerpia"
        }
    
    private let searchButton = UIButton(type: .system)
        .then {
            $0.setBackgroundImage(ImageLiteral.imgSearch, for: .normal)
        }
    
    private let recommendContentsView = RecommendContentsView()
    
    private let recordButton = UIButton(type: .system)
        .then {
            $0.setImage(ImageLiteral.imgAdd.resize(to: CGSize(width: 40, height: 40)).withRenderingMode(.alwaysOriginal), for: .normal)
            $0.layer.cornerRadius = 20
            $0.backgroundColor = .blue400
        }
    
    private let recordButtonTitle = UILabel()
        .then {
            $0.textColor = .white
            $0.font = .pretendard(.semibold, ofSize: 22)
            $0.text = "러너피아로 지금 달려볼까요?"
        }
    
    private let recordButtonSubLabel = UILabel()
        .then {
            $0.font = .pretendard(.bold, ofSize: 12)
            $0.text = "누르면 기록이 시작돼요"
            $0.textColor = .white
        }
    
    private let safeTagContentsView = SafeTagContentsView()
    
    // MARK: - Properties
    
    // MARK: - Functions
    override func configUI() {
        view.backgroundColor = .init(hex: "#F5F5F5")
    }
    
    override func render() {
        [appTitle, searchButton, recommendContentsView, recordButton, recordButtonTitle, recordButtonSubLabel, safeTagContentsView].forEach { view.addSubview($0) }
        
        appTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view).offset(16)
        }
        
        searchButton.snp.makeConstraints { make in
            make.trailing.equalTo(view).offset(-16)
            make.centerY.equalTo(appTitle)
        }
        
        recommendContentsView.snp.makeConstraints { make in
            make.top.equalTo(appTitle.snp.bottom).offset(24)
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).offset(-16)
            make.height.equalTo(110)
        }
        
        recordButton.snp.makeConstraints { make in
            make.top.equalTo(recommendContentsView.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).offset(-16)
            make.height.equalTo(recordButton.snp.width)
        }
        
        recordButtonTitle.snp.makeConstraints { make in
            make.top.equalTo(recordButton).offset(24)
            make.centerX.equalTo(recordButton)
        }
        
        recordButtonSubLabel.snp.makeConstraints { make in
            make.bottom.equalTo(recordButton).offset(-24)
            make.centerX.equalTo(recordButton)
        }
        
        safeTagContentsView.snp.makeConstraints { make in
            make.top.equalTo(recordButton.snp.bottom).offset(14)
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).offset(-16)
            make.height.greaterThanOrEqualTo(77)
        }
    }
    
    // MARK: - Objc functions
    @objc
    func recordButtonTapped() {
        print("HI")
    }
}
