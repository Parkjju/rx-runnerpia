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
            $0.font = .pretendard(.semibold, ofSize: 24)
            $0.text = "러너피아,\n이제 안심한 경로로 러닝하세요."
        }
    
    // MARK: - Functions
    override func render() {
        view.addSubViews([backgroundImageView, dimmingView])
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        dimmingView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    override func configUI() {
        
    }
}
