//
//  LoginViewController.swift
//  runnerpia
//
//  Created by 박경준 on 12/1/23.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - Subviews
    
    let backgroundImageView = UIImageView(image: UIImage(named: "imgBackground"))
        .then {
            $0.layer.zPosition = -1
            $0.contentMode = .scaleAspectFill
        }
    
    let dimmingView = UIView()
        .then {
            $0.backgroundColor = .black.withAlphaComponent(0.5)
        }
    
    let mainLabel = UILabel()
        .then {
            let attributedString = NSMutableAttributedString(string: "러너피아,\n이제 안심한 경로로 러닝하세요.")
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 2.5 // Whatever line spacing you want in points
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            $0.attributedText = attributedString
            
            $0.numberOfLines = 0
            $0.textAlignment = .left
            $0.textColor = .white
            $0.font = .pretendard(.semibold, ofSize: 24)
        }
    
    let kakaoLoginButton = UIButton(type: .system)
        .then {
            $0.setImage(ImageLiteral.imgKakaoLogo.withRenderingMode(.alwaysOriginal), for: .normal)
            var configuration = UIButton.Configuration.filled()
            configuration.baseBackgroundColor = .init(hex: "#FEE500")
            configuration.imagePadding = 10
            let attrString = NSAttributedString(string: "카카오 로그인", attributes: [NSAttributedString.Key.font: UIFont.pretendard(.medium, ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.init(hex: "#191600")])
            configuration.attributedTitle = AttributedString(attrString)
            $0.configuration = configuration
            $0.semanticContentAttribute = .forceLeftToRight
            $0.backgroundColor = .init(hex: "#FEE500")
            $0.titleLabel?.font = .pretendard(.medium, ofSize: 16)
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
        }
    
    let appleLoginButton = UIButton(type: .system)
        .then {
            $0.setImage(ImageLiteral.imgAppleLogo.withRenderingMode(.alwaysOriginal), for: .normal)
            var configuration = UIButton.Configuration.filled()
            configuration.baseBackgroundColor = .init(hex: "#000000")
            configuration.imagePadding = 10
            let attrString = NSAttributedString(string: "Apple로 로그인", attributes: [NSAttributedString.Key.font: UIFont.pretendard(.medium, ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.init(hex: "#FFFFFF")])
            configuration.attributedTitle = AttributedString(attrString)
            $0.configuration = configuration
            $0.semanticContentAttribute = .forceLeftToRight
            $0.backgroundColor = .init(hex: "#000000")
            $0.titleLabel?.font = .pretendard(.bold, ofSize: 16)
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
        }
    
    let agreeLabel = UILabel()
        .then {
            $0.textAlignment = .center
            $0.font = .pretendard(.regular, ofSize: 12)
            $0.textColor = .init(hex: "#C8C8C8")
            $0.text = "로그인함으로써 Runningmap의 정책 및 약관에 동의합니다."
        }
    
    let termsOfServiceButton = UIButton(type: .system)
        .then {
            $0.addBorder(toSide: .Bottom, withColor: UIColor.init(hex: "#c8c8c8").cgColor, andThickness: 1)
            $0.titleLabel?.font = .pretendard(.medium, ofSize: 12)
            $0.backgroundColor = .clear
            $0.setTitleColor(.init(hex: "#c8c8c8"), for: .normal)
            $0.setTitle("서비스 이용약관", for: .normal)
        }
    
    let privacyPolicyButton = UIButton(type: .system)
        .then {
            $0.addBorder(toSide: .Bottom, withColor: UIColor.init(hex: "#c8c8c8").cgColor, andThickness: 1)
            $0.titleLabel?.font = .pretendard(.medium, ofSize: 12)
            $0.backgroundColor = .clear
            $0.setTitleColor(.init(hex: "#c8c8c8"), for: .normal)
            $0.setTitle("개인정보 처리방침", for: .normal)
        }
    
    let locationTerms = UIButton(type: .system)
        .then {
            $0.titleLabel?.font = .pretendard(.medium, ofSize: 12)
            $0.backgroundColor = .clear
            $0.setTitleColor(.init(hex: "#c8c8c8"), for: .normal)
            $0.setTitle("위치정보 이용약관", for: .normal)
        }
    
    // MARK: - Functions
    override func render() {
        view.addSubViews([backgroundImageView, dimmingView, termsOfServiceButton, agreeLabel, privacyPolicyButton, locationTerms, kakaoLoginButton, appleLoginButton, mainLabel])
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        dimmingView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        agreeLabel.snp.makeConstraints { make in
            make.leading.equalTo(termsOfServiceButton)
            make.trailing.equalTo(locationTerms)
            make.bottom.equalTo(privacyPolicyButton.snp.top).offset(-5)
        }
        
        termsOfServiceButton.snp.makeConstraints { make in
            make.trailing.equalTo(privacyPolicyButton.snp.leading).offset(-18)
            make.bottom.equalTo(privacyPolicyButton)
        }
        
        privacyPolicyButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.centerX.equalToSuperview()
        }
        
        locationTerms.snp.makeConstraints { make in
            make.leading.equalTo(privacyPolicyButton.snp.trailing).offset(18)
            make.bottom.equalTo(privacyPolicyButton)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(appleLoginButton.snp.top).offset(-14)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(agreeLabel.snp.top).offset(-30)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.bottom.equalTo(kakaoLoginButton.snp.top).offset(-40)
            make.leading.equalToSuperview().offset(28)
        }
        
        setButtonBorder()
    }
    
    override func configUI() {
    }
    
    func setButtonBorder() {
        let locationTermslineView = UIView(frame: CGRect(x: 0, y: locationTerms.intrinsicContentSize.height - 2, width: locationTerms.intrinsicContentSize.width, height: 1))
        locationTermslineView.backgroundColor = UIColor.init(hex: "#C8C8C8").withAlphaComponent(0.8)
        locationTerms.addSubview(locationTermslineView)
        
        let privacyPolicyLineView = UIView(frame: CGRect(x: 0, y: privacyPolicyButton.intrinsicContentSize.height - 2, width: privacyPolicyButton.intrinsicContentSize.width, height: 1))
        privacyPolicyLineView.backgroundColor = UIColor.init(hex: "#C8C8C8").withAlphaComponent(0.8)
        privacyPolicyButton.addSubview(privacyPolicyLineView)
        
        let termsOfServiceLineView = UIView(frame: CGRect(x: 0, y: termsOfServiceButton.intrinsicContentSize.height - 2, width: termsOfServiceButton.intrinsicContentSize.width, height: 1))
        termsOfServiceLineView.backgroundColor = UIColor.init(hex: "#C8C8C8").withAlphaComponent(0.8)
        termsOfServiceButton.addSubview(termsOfServiceLineView)
    }
}
