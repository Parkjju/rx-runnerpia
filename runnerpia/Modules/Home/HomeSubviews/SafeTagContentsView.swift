//
//  SafeTagContentsView.swift
//  runnerpia
//
//  Created by Jun on 2023/10/10.
//

import UIKit

class SafeTagContentsView: UIView {
    
    // MARK: - Subviews
    let subLabel = UILabel()
        .then {
            $0.font = .pretendard(.regular, ofSize: 12)
            $0.text = "밤 늦게 러닝, 그 동안 무서우셨죠?"
        }
    
    let mainLabel = UILabel()
        .then {
            $0.font = .pretendard(.semibold, ofSize: 16)
            $0.text = "러너피아에는 안심 태그가 있어요!"
        }
    
    let alertImageView = UIImageView()
        .then {
            $0.image = ImageLiteral.imgImportantFilled.withRenderingMode(.alwaysOriginal)
        }
    
    let detailButton = UIButton(type: .system)
        .then {
            $0.setImage(ImageLiteral.imgRightAngle.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        render()
        configUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func render() {
        self.addSubViews([subLabel, mainLabel, alertImageView, detailButton])
        
        alertImageView.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(16)
            make.centerY.equalTo(self)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(17)
            make.leading.equalTo(alertImageView.snp.trailing).offset(6)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(subLabel)
            make.bottom.equalTo(self).offset(-17)
        }
        
        detailButton.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-16)
            make.centerY.equalTo(self)
        }
    }

    func configUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
    }
}
