//
//  PhotoCellViewModel.swift
//  runnerpia
//
//  Created by Jun on 2023/10/18.
//

import Foundation
import RxCocoa
import RxSwift

class PhotoCellViewModel {
    let photoCell = BehaviorRelay<UIImage?>(value: nil)
    let isFirstCell = BehaviorRelay<Bool>(value: true)
    
    init(with imageData: UIImage?) {
        guard let imageData = imageData else { return }
        photoCell.accept(imageData)
        isFirstCell.accept(false)
    }
}
