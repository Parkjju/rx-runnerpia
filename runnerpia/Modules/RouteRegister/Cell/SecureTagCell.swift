//
//  SecureTagCell.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/17.
//

import UIKit

class SecureTagCell: BaseCollectionViewCell {
    
    // MARK: - Subviews
    let cellLabel = UILabel()
        .then {
            $0.font = .pretendard(.medium, ofSize: 14)
        }
    
    // MARK: - Properties
    
    static let identifier = "SecureTagCell"
    
    // MARK: - Functions
    
    func bind(to viewModel: SecureTagCellViewModel) {
        viewModel.title.bind(to: cellLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.isSelected.asDriver()
            .drive(onNext: { [unowned self] in
                if $0 {
                    self.layer.opacity = 1
                } else {
                    self.layer.opacity = 0.6
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func render() {
        self.addSubViews([cellLabel])
        
        cellLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(6)
            make.bottom.equalTo(self).offset(-6)
            make.leading.equalTo(self).offset(12)
            make.trailing.equalTo(self).offset(-12)
        }
    }
    
    override func configUI() {
        self.backgroundColor = .blue200
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        alpha = 0.6
    }
}
