//
//  SecureTagSelection.swift
//  runnerpia
//
//  Created by Jun on 2023/10/19.
//

import UIKit

class SecureTagSelection: UIView {
    
    // MARK: - Subviews
    
    let secureTagLabel = UILabel()
        .then {
            $0.font = .pretendard(.medium, ofSize: 16)
            $0.text = "안심태그"
        }
    
    let secureTagCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(SecureTagCell.self, forCellWithReuseIdentifier: SecureTagCell.identifier)
        
        return cv
    }()
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        render()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func render() {
        self.addSubViews([secureTagLabel, secureTagCollectionView])
        
        secureTagLabel.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.equalTo(self)
        }
        
        secureTagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(secureTagLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(60)
        }
    }
}
