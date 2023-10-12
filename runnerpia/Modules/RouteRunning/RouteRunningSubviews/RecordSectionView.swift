//
//  RecordSectionView.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/11.
//

import UIKit

class RecordSectionView: UIView {
    
    // MARK: - Subviews
    let defaultLabel = UILabel()
        .then {
            $0.font = .pretendard(.semibold, ofSize: 18)
            $0.text = "플레이 버튼을 3초 이상 누르면 시작돼요!"
        }
    
    let timeLabel = UILabel()
        .then {
            $0.isHidden = true
            $0.font = .pretendard(.bold, ofSize: 34)
            $0.text = "00:00"
        }
    
    let timeSubLabel = UILabel()
        .then {
            $0.isHidden = true
            $0.font = .pretendard(.semibold, ofSize: 18)
            $0.text = "시간"
        }
    
    let distanceLabel = UILabel()
        .then {
            $0.textAlignment = .center
            $0.isHidden = true
            $0.text = "0.00km"
            $0.font = .pretendard(.bold, ofSize: 34)
        }
    
    let distanceSubLabel = UILabel()
        .then {
            $0.isHidden = true
            $0.font = .pretendard(.semibold, ofSize: 18)
            $0.text = "거리"
        }
    
    let recordTriggerButton = UIButton(type: .system)
        .then {
            $0.backgroundColor = .init(hex: "#0083E2")
            $0.setImage(ImageLiteral.imgPlay.resize(to: CGSize(width: 48, height: 48)).withRenderingMode(.alwaysOriginal), for: .normal)
        }
    
    let pauseButton = UIButton(type: .system)
        .then {
            $0.isHidden = true
            $0.setImage(ImageLiteral.imgPause.resize(to: CGSize(width: 48, height: 48)).withRenderingMode(.alwaysOriginal), for: .normal)
            $0.backgroundColor = .init(hex: "#737373")
        }
    
    let playButton = UIButton(type: .system)
        .then {
            $0.isHidden = true
            $0.backgroundColor = .init(hex: "#0083E2")
            $0.setImage(ImageLiteral.imgPlay.resize(to: CGSize(width: 48, height: 48)).withRenderingMode(.alwaysOriginal), for: .normal)
        }
    
    let stopButton = UIButton(type: .system)
        .then {
            $0.isHidden = true
            $0.backgroundColor = .init(hex: "#FF645A")
            $0.setImage(ImageLiteral.imgStop.resize(to: CGSize(width: 48, height: 48)).withRenderingMode(.alwaysOriginal), for: .normal)
        }
    
    
    // MARK: - Properties
    
    enum ButtonState {
        case record
        case pause
        case stop
    }
    
    var recordState: ButtonState = .record
    
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
        self.addSubViews([defaultLabel, timeLabel, timeSubLabel, distanceLabel, recordTriggerButton, distanceSubLabel, pauseButton, playButton, stopButton])
        
        defaultLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(14)
            make.centerX.equalTo(self)
        }
        
        recordTriggerButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(defaultLabel.snp.bottom).offset(26)
            make.height.width.equalTo(90)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.top.equalTo(self).offset(30)
            make.centerX.equalTo(timeSubLabel)
        }
        
        timeSubLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom)
            make.leading.equalTo(self).offset(80)
        }
        
        distanceLabel.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.top.equalTo(timeLabel)
            make.centerX.equalTo(distanceSubLabel)
        }
        
        distanceSubLabel.snp.makeConstraints { make in
            make.top.equalTo(distanceLabel.snp.bottom)
            make.trailing.equalTo(self).offset(-80)
        }
        
        pauseButton.snp.makeConstraints { make in
            make.top.equalTo(distanceSubLabel.snp.bottom).offset(10)
            make.centerX.equalTo(self)
            make.width.height.equalTo(90)
        }
        
        playButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.centerX).offset(-30)
            make.top.equalTo(distanceSubLabel.snp.bottom).offset(10)
            make.width.height.equalTo(90)
        }
        
        stopButton.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.centerX).offset(30)
            make.top.equalTo(distanceSubLabel.snp.bottom).offset(10)
            make.width.height.equalTo(90)
        }
    }
    
    func configUI() {
        pauseButton.layer.cornerRadius = 45
        playButton.layer.cornerRadius = 45
        stopButton.layer.cornerRadius = 45
        recordTriggerButton.layer.cornerRadius = 45
        
        self.backgroundColor = .white.withAlphaComponent(0.8)
    }
}
