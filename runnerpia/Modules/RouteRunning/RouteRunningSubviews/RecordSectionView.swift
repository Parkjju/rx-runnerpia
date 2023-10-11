//
//  RecordSectionView.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/11.
//

import UIKit

class RecordSectionView: UIView {
    
    // MARK: - Subviews
    let timeLabel = UILabel()
        .then {
            $0.font = .pretendard(.bold, ofSize: 34)
            $0.text = "00:00"
        }
    let timeSubLabel = UILabel()
        .then {
            $0.font = .pretendard(.semibold, ofSize: 18)
            $0.text = "시간"
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
        
    }
    
    func configUI() {
        
    }
}
