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
    
    let initialText = "최소 30자 이상 작성해주세요. (비방, 욕설을 포함한 관련없는 내용은 통보 없이 삭제될 수 있습니다.)"
    let paragraphStyle = NSMutableParagraphStyle()
        .then {
            $0.lineSpacing = 4
        }
    
    lazy var initialProperty = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular, width: .standard), NSAttributedString.Key.foregroundColor: UIColor.init(hex: "#8B8B8B"), NSAttributedString.Key.paragraphStyle: self.paragraphStyle]
    lazy var changedProperty = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular, width: .standard), NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.paragraphStyle: self.paragraphStyle]
    
    
    struct Input {
        let secureTagSelected: Observable<SecureTagCellViewModel>
        let recommendedTagSelected: Observable<RecommendedTagCellViewModel>
        let photoCellSelected: Observable<PhotoCellViewModel>
        let selectedImages: Observable<UIImage>
        let removeTargetItem: Observable<Int>
        let textViewDidBeginEditing: Observable<Void>
        let textViewDidEndEditing: Observable<Void>
        let inputText: ControlProperty<String?>
    }
    
    struct Output {
        let secureTagCellItems: Driver<[SecureTagCellViewModel]>
        let recommendedTagCellItems: Driver<[RecommendedTagCellViewModel]>
        let photoCellItems: Driver<[PhotoCellViewModel]>
        let presentPickerView: Driver<Void>
        let attributedText: Observable<NSAttributedString>
        let textCount: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        let secureTagItems = BehaviorRelay<[SecureTagCellViewModel]>(value: [])
        let recommendedTagItems = BehaviorRelay<[RecommendedTagCellViewModel]>(value: [])
        let photoItems = BehaviorRelay<[PhotoCellViewModel]>(value: [PhotoCellViewModel(with: nil)])
        let presentPickerView = PublishSubject<Void>()
        let secureTagSelectedCount = BehaviorRelay<Int>(value: 0)
        let recommendedTagSelectedCount = BehaviorRelay<Int>(value: 0)
        let attributedText = BehaviorRelay<NSAttributedString>(value: NSAttributedString(string: ""))
        let textCountLabel = BehaviorRelay<String>(value: "")
        
        /// 안심태그 셀렉션
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
        
        /// 일반태그 셀렉션
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
        
        /// 0번째 셀 탭 이후 이미지 피커뷰 present 로직
        input.photoCellSelected
            .subscribe(onNext: {
                if let _ = $0.photoCell.value { return }
                presentPickerView.onNext(())
            })
            .disposed(by: disposeBag)
        
        /// 컬렉션뷰 셀 바인딩 로직
        input.selectedImages
            .map { image -> PhotoCellViewModel in
                let vm = PhotoCellViewModel(with: image)
                return vm
            }
            .subscribe(onNext: {
                photoItems.accept(photoItems.value + [$0])
            })
            .disposed(by: disposeBag)
        
        /// 이미지 삭제 로직
        input.removeTargetItem
            .subscribe(onNext: {
                var newItems = photoItems.value
                newItems.remove(at: $0)
                photoItems.accept(newItems)
            })
            .disposed(by: disposeBag)
        
        /// 300자 제한 로직
        input.inputText
            .compactMap { $0 }
            .scan("") { prev, new in
                return new.count <= 300 ? new : prev
            }
            .map { [unowned self] str -> NSAttributedString in
                if str == self.initialText {
                    return NSAttributedString(string: str, attributes: self.initialProperty)
                } else {
                    return NSAttributedString(string: str, attributes: self.changedProperty)
                }
            }
            .subscribe(onNext: {
                attributedText.accept($0)
            })
            .disposed(by: disposeBag)
        
        /// 글자수 카운팅
        input.inputText
            .compactMap { $0 }
            .map { [unowned self] in
                return $0 == self.initialText ? "0 / 300" : "\($0.count) / 300"
            }
            .subscribe(onNext: {
                textCountLabel.accept($0)
            })
            .disposed(by: disposeBag)
        
        /// 텍스트 입력 시작 후 어트리뷰트 스트링 속성 바인딩
        input.textViewDidBeginEditing
            .subscribe(onNext: { [unowned self] in
                if attributedText.value.string == self.initialText {
                    attributedText.accept(NSAttributedString(string: "", attributes: self.changedProperty))
                }
            })
            .disposed(by: disposeBag)
        
        /// 텍스트 입력 종료 후 어트리뷰트 속성 바인딩
        input.textViewDidEndEditing
            .subscribe(onNext: { [unowned self] in
                if attributedText.value.string == "" {
                    attributedText.accept(NSAttributedString(string: self.initialText, attributes: self.initialProperty))
                } else if attributedText.value.string == self.initialText {
                    attributedText.accept(NSAttributedString(string: self.initialText, attributes: self.changedProperty))
                }
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
        
        
        
        return Output(secureTagCellItems: secureTagItems.asDriver(), recommendedTagCellItems: recommendedTagItems.asDriver(), photoCellItems: photoItems.asDriver(), presentPickerView: presentPickerView.asDriver(onErrorJustReturn: ()), attributedText: attributedText.asObservable(), textCount: textCountLabel.asObservable())
    }
}
