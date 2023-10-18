//
//  PhotoCell.swift
//  runnerpia
//
//  Created by Jun on 2023/10/18.
//

import UIKit

class PhotoCell: BaseCollectionViewCell {
    
    // MARK: - Subviews
    let imageView = UIImageView()
        .then {
            $0.image = ImageLiteral.imgClose
            $0.contentMode = .scaleAspectFill
        }
    
    let removeButton = UIButton(type: .system)
        .then {
            $0.isHidden = true
            $0.setImage(ImageLiteral.imgDeleteLine.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    
    let addImageView = UIImageView(image: ImageLiteral.imgPlus.withRenderingMode(.alwaysOriginal))
    
    // MARK: - Properties
    static let identifier = "PhotoCell"
    
    // MARK: - Functions
    func bind(to viewModel: PhotoCellViewModel) {
        viewModel.photoCell.bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
    
    override func render() {
        self.addSubViews([imageView, removeButton, addImageView])
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        removeButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.width.height.equalTo(20)
        }
        
        addImageView.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(self)
        }
    }
    
    override func configUI() {
        backgroundColor = .grey100
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
