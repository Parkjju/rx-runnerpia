//
//  RouteRegisterViewModel.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/13.
//

import Foundation
import RxCocoa
import RxSwift

class RouteRegisterViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let secureTagSelected: Observable<SecureTagCellViewModel>
        let recommendedTagSelected: Observable<RecommendedTagCellViewModel>
        let photoCellSelected: Observable<PhotoCellViewModel>
        let selectedImages: Observable<UIImage>
        let removeTargetItem: Observable<Int>
    }
    
    struct Output {
        let secureTagCellItems: Driver<[SecureTagCellViewModel]>
        let recommendedTagCellItems: Driver<[RecommendedTagCellViewModel]>
        let photoCellItems: Driver<[PhotoCellViewModel]>
        let presentPickerView: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        let secureTagItems = BehaviorRelay<[SecureTagCellViewModel]>(value: [])
        let recommendedTagItems = BehaviorRelay<[RecommendedTagCellViewModel]>(value: [])
        let photoItems = BehaviorRelay<[PhotoCellViewModel]>(value: [PhotoCellViewModel(with: nil)])
        let presentPickerView = PublishSubject<Void>()
        let secureTagSelectedCount = BehaviorRelay<Int>(value: 0)
        let recommendedTagSelectedCount = BehaviorRelay<Int>(value: 0)
        
        input.secureTagSelected
            .subscribe(onNext: {
                $0.isSelected.accept(!$0.isSelected.value)
                
                if $0.isSelected.value {
                    secureTagSelectedCount.accept(secureTagSelectedCount.value + 1)
                } else {
                    secureTagSelectedCount.accept(secureTagSelectedCount.value - 1)
                }
            })
            .disposed(by: disposeBag)
        
        input.recommendedTagSelected
            .subscribe(onNext: {
                $0.isSelected.accept(!$0.isSelected.value)
                
                if $0.isSelected.value {
                    recommendedTagSelectedCount.accept(secureTagSelectedCount.value + 1)
                } else {
                    recommendedTagSelectedCount.accept(secureTagSelectedCount.value - 1)
                }
            })
            .disposed(by: disposeBag)
        
        input.photoCellSelected
            .subscribe(onNext: {
                if let _ = $0.photoCell.value { return }
                presentPickerView.onNext(())
            })
            .disposed(by: disposeBag)
        
        input.selectedImages
            .map { image -> PhotoCellViewModel in
                let vm = PhotoCellViewModel(with: image)
                return vm
            }
            .subscribe(onNext: {
                photoItems.accept(photoItems.value + [$0])
            })
            .disposed(by: disposeBag)
        
        input.removeTargetItem
            .subscribe(onNext: {
                var newItems = photoItems.value
                newItems.remove(at: $0)
                photoItems.accept(newItems)
            })
            .disposed(by: disposeBag)
        
        secureTagItems.accept(SecureTags.retrieveAllSecureTagsWithArray()
            .map {
                SecureTagCellViewModel(with: $0)
            })
        
        recommendedTagItems.accept(RecommendTags.retrieveAllRecommendedTagsWithArray()
            .map {
                RecommendedTagCellViewModel(with: $0)
            })
        
        
        
        return Output(secureTagCellItems: secureTagItems.asDriver(), recommendedTagCellItems: recommendedTagItems.asDriver(), photoCellItems: photoItems.asDriver(), presentPickerView: presentPickerView.asDriver(onErrorJustReturn: ()))
    }
}
