//
//  RecommendContentsView.swift
//  runnerpia
//
//  Created by Jun on 2023/10/10.
//

import UIKit

class RecommendContentsView: UIView {
    
    // MARK: - Subviews
    private let subLabel = UILabel()
        .then {
            $0.font = .pretendard(.regular, ofSize: 12)
            $0.text = "어디로 달려야할지 모르겠다구요?"
        }
    
    private let mainLabel = UILabel()
        .then {
            $0.font = .pretendard(.semibold, ofSize: 16)
            $0.text = "에디터의 러닝 기록을 따라가 보세요!"
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
    
    func render() {
        self.addSubViews([subLabel, mainLabel])
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(32)
            make.leading.equalTo(self).offset(16)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(4)
            make.leading.equalTo(self).offset(16)
        }
    }
    
    func configUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
    }
}
