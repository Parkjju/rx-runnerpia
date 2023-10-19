//
//  RecommendedTagSelection.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/19.
//

import UIKit

class RecommendedTagSelection: UIView {

    // MARK: - Subviews
    
    let recommendedTagLabel = UILabel()
        .then {
            $0.font = .pretendard(.medium, ofSize: 16)
            $0.text = "안심태그"
        }
    
    let recommendedTagCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(RecommendedTagCell.self, forCellWithReuseIdentifier: RecommendedTagCell.identifier)
        
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
        self.addSubViews([recommendedTagLabel, recommendedTagCollectionView])
        
        recommendedTagLabel.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.equalTo(self)
        }
        
        recommendedTagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendedTagLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(60)
        }
    }
}
