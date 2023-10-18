//
//  RouteRegisterViewController.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/13.
//

import UIKit
import NMapsMap
import RxCocoa
import RxSwift
import PhotosUI

class RouteRegisterViewController: BaseViewController {
    
    // MARK: - Subviews
    let mapView = NMFMapView()
        .then {
            $0.allowsZooming = false
            $0.allowsRotating = false
            $0.allowsTilting = false
            $0.allowsScrolling = false
        }
    
    let scrollView = UIScrollView()
        .then { sv in
            let view = UIView()
            sv.addSubview(view)
            view.snp.makeConstraints {
                $0.top.equalTo(sv.contentLayoutGuide.snp.top)
                $0.leading.equalTo(sv.contentLayoutGuide.snp.leading)
                $0.trailing.equalTo(sv.contentLayoutGuide.snp.trailing)
                $0.bottom.equalTo(sv.contentLayoutGuide.snp.bottom)

                $0.leading.equalTo(sv.frameLayoutGuide.snp.leading)
                $0.trailing.equalTo(sv.frameLayoutGuide.snp.trailing)
                $0.height.equalTo(sv.frameLayoutGuide.snp.height).priority(.low)
            }
        }
    
    let completeLabel = UILabel()
        .then {
            $0.font = UIFont.boldSystemFont(ofSize: 24)
            $0.numberOfLines = 0
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            
            let runningTitleText = NSMutableAttributedString(string: "송정뚝방길\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .semibold, width: .standard), NSAttributedString.Key.paragraphStyle: paragraphStyle])
            
            let text = NSMutableAttributedString(string: "러닝을 완료", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .semibold, width: .standard), NSAttributedString.Key.foregroundColor: UIColor.blue400])
            
            let remainText = NSMutableAttributedString(string: "했어요!", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .semibold, width: .standard)])
            
            runningTitleText.append(text)
            runningTitleText.append(remainText)
            
            $0.attributedText = runningTitleText
        }
    
    let locationView: UIStackView = UIStackView()
        .then { sv in
            let firstMarkerImage = UIImageView(image: ImageLiteral.imgLocationFilled)
            let secondMarkerImage = UIImageView(image: ImageLiteral.imgLocationFilled)

            let startLocationLabel = UILabel()
            startLocationLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
            startLocationLabel.text = "성동구 송정동"

            let rightArrowImage = UIImageView(image: UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal))

            let endLocationLabel = UILabel()
            endLocationLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
            endLocationLabel.text = "성동구 송정동"

            [firstMarkerImage, startLocationLabel, rightArrowImage, secondMarkerImage,endLocationLabel].forEach { sv.addArrangedSubview($0) }

            sv.spacing = 8
            sv.distribution = .fillProportionally
            sv.alignment = .fill
        }
    
    let dateView = UIView()
        .then { view in
            let calendarImage = UIImageView(image: ImageLiteral.imgCalendarLine)
            
            // MARK: 데이터 전달받고 dateFormatting 후 문자열 추가
            let date = UILabel()
            date.text = "12월 31일 토요일 오후 7시 30분 시작"
            date.font = UIFont.systemFont(ofSize: 14, weight: .light)
            
            [calendarImage, date].forEach { view.addSubview($0) }

            calendarImage.snp.makeConstraints {
                $0.leading.equalTo(view.snp.leading)
                $0.centerY.equalTo(view.snp.centerY)
                $0.width.equalTo(20)
            }
            
            date.snp.makeConstraints {
                $0.centerY.equalTo(view.snp.centerY)
                $0.leading.equalTo(calendarImage.snp.trailing).offset(8)
            }
        }
    
    let timeView: UIView = UIView()
        .then { view in
            let clockImage = UIImageView(image: ImageLiteral.imgTimeLine)

            let timeLabel = UILabel()
            timeLabel.text = "34분 21초"
            timeLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)

            [clockImage, timeLabel].forEach { view.addSubview($0) }

            clockImage.snp.makeConstraints {
                $0.centerY.equalTo(view.snp.centerY)
                $0.leading.equalTo(view.snp.leading)
                $0.width.equalTo(20)
            }

            timeLabel.snp.makeConstraints {
                $0.centerY.equalTo(view.snp.centerY)
                $0.leading.equalTo(clockImage.snp.trailing).offset(8)
            }
        }
    
    let distanceView: UIView = UIView()
        .then { view in
            let mapImage = UIImageView(image: ImageLiteral.imgRouteLine)

            let distanceLabel = UILabel()
            distanceLabel.text = "5.8km"
            distanceLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)

            [mapImage, distanceLabel].forEach { view.addSubview($0) }

            mapImage.snp.makeConstraints {
                $0.centerY.equalTo(view.snp.centerY)
                $0.leading.equalTo(view.snp.leading)
            }

            distanceLabel.snp.makeConstraints {
                $0.leading.equalTo(mapImage.snp.trailing).offset(8)
                $0.centerY.equalTo(view.snp.centerY)
            }
        }
    
    let divider = UIImageView(image: ImageLiteral.imgDivider)
    
    let tagLabel = UILabel()
        .then {
            $0.font = .pretendard(.semibold, ofSize: 18)
            $0.text = "다녀오신 경로를 평가해주세요!"
        }
    
    let secureTagLabel = UILabel()
        .then {
            $0.font = .pretendard(.medium, ofSize: 16)
            $0.text = "안심태그"
        }
    
    let recommendedTagLabel = UILabel()
        .then {
            $0.text = "일반태그"
            $0.font = .pretendard(.medium, ofSize: 16)
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
    
    let dividerUnderTags = UIImageView(image: ImageLiteral.imgDivider)
    
    let reviewLabel = UILabel()
        .then {
            $0.font = .pretendard(.semibold, ofSize: 18)
            $0.text = "추천하는 경로에 대해 소개해 주세요!"
        }
    
    lazy var reviewTextView = UITextView()
        .then {
            $0.font = .pretendard(.regular, ofSize: 14)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
            $0.layer.borderColor = UIColor(hex: "#DFDFDF").cgColor
            $0.layer.borderWidth = 1
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.text = self.initialText
        }
    
    let reviewTextCountLabel = UILabel()
        .then {
            $0.font = .pretendard(.medium, ofSize: 14)
            $0.textColor = .init(hex: "#A5A5A5")
        }
    
    let photoTextLabel = UILabel()
        .then {
            $0.font = .pretendard(.semibold, ofSize: 18)
            $0.text = "경험했던 경로의 사진을 등록해주세요"
        }
    
    let photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 62) / 4, height: (UIScreen.main.bounds.width - 62) / 4)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        
        return cv
    }()
    
    
    // MARK: - Properties
    var viewModel: RouteRegisterViewModel
    var homeFlow: HomeFlow
    let initialText = "최소 30자 이상 작성해주세요. (비방, 욕설을 포함한 관련없는 내용은 통보 없이 삭제될 수 있습니다.)"
    let paragraphStyle = NSMutableParagraphStyle()
        .then {
            $0.lineSpacing = 4
        }
    
    lazy var initialProperty = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular, width: .standard), NSAttributedString.Key.foregroundColor: UIColor.init(hex: "#8B8B8B"), NSAttributedString.Key.paragraphStyle: self.paragraphStyle]
    lazy var changedProperty = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular, width: .standard), NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.paragraphStyle: self.paragraphStyle]
    
    let imagePickerObservable = PublishSubject<UIImage>()
    let removeButtonTapTrigger = PublishSubject<Int>()
    
    // MARK: - Functions
    
    init(viewModel: RouteRegisterViewModel, homeFlow: HomeFlow) {
        self.viewModel = viewModel
        self.homeFlow = homeFlow
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func render() {
        view.addSubView(scrollView)
        
        scrollView.subviews.first!.addSubViews([mapView, completeLabel, locationView, dateView, timeView, distanceView, divider, tagLabel, secureTagLabel, secureTagCollectionView, recommendedTagLabel, recommendedTagCollectionView, dividerUnderTags, reviewLabel, reviewTextView, reviewTextCountLabel, photoTextLabel, photoCollectionView])
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.subviews.first!.snp.top)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.height.equalTo(260)
        }
        
        completeLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.leading.equalTo(mapView.snp.leading)
        }
        
        locationView.snp.makeConstraints { make in
            make.top.equalTo(completeLabel.snp.bottom).offset(16)
            make.leading.equalTo(mapView.snp.leading)
        }
        
        dateView.snp.makeConstraints { make in
            make.top.equalTo(locationView.snp.bottom).offset(16)
            make.leading.equalTo(mapView)
            make.height.equalTo(20)
        }
        
        timeView.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom).offset(10)
            make.leading.equalTo(mapView)
            make.height.equalTo(20)
        }
        
        distanceView.snp.makeConstraints { make in
            make.top.equalTo(timeView.snp.bottom).offset(10)
            make.leading.equalTo(mapView)
            make.height.equalTo(20)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(distanceView.snp.bottom).offset(20)
            make.leading.equalTo(mapView)
            make.trailing.equalTo(mapView)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(20)
            make.leading.equalTo(mapView)
        }
        
        secureTagLabel.snp.makeConstraints { make in
            make.top.equalTo(tagLabel.snp.bottom).offset(16)
            make.leading.equalTo(mapView)
        }
        
        secureTagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(secureTagLabel.snp.bottom).offset(10)
            make.leading.equalTo(mapView.snp.leading)
            make.trailing.equalTo(mapView.snp.trailing)
            make.height.equalTo(60)
        }
        
        recommendedTagLabel.snp.makeConstraints { make in
            make.leading.equalTo(mapView)
            make.top.equalTo(secureTagCollectionView.snp.bottom).offset(20)
        }
        
        recommendedTagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendedTagLabel.snp.bottom).offset(10)
            make.leading.equalTo(mapView.snp.leading)
            make.trailing.equalTo(mapView.snp.trailing)
            make.height.equalTo(60)
        }
        
        dividerUnderTags.snp.makeConstraints { make in
            make.top.equalTo(recommendedTagCollectionView.snp.bottom).offset(20)
            make.leading.equalTo(mapView)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerUnderTags.snp.bottom).offset(20)
            make.leading.equalTo(mapView)
        }
        
        reviewTextView.snp.makeConstraints { make in
            make.top.equalTo(reviewLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(mapView)
            make.height.equalTo(215)
        }
        
        reviewTextCountLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewTextView.snp.bottom).offset(10)
            make.trailing.equalTo(mapView)
        }
        
        photoTextLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewTextCountLabel.snp.bottom).offset(20)
            make.leading.equalTo(mapView)
        }
        
        photoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(photoTextLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(mapView)
            make.height.equalTo(120)
            make.bottom.equalTo(scrollView.snp.bottom).offset(-20)
        }
    }
    
    override func configUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "러닝 내역"
        
        let rightBarButtonItem = UIBarButtonItem(image: ImageLiteral.imgClose.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped))
        recognizer.numberOfTapsRequired = 1
        recognizer.isEnabled = true
        recognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(recognizer)
    }
    
    override func bindViewModel() {
        let input = RouteRegisterViewModel.Input(secureTagSelected: secureTagCollectionView.rx.modelSelected(SecureTagCellViewModel.self).asObservable(), recommendedTagSelected: recommendedTagCollectionView.rx.modelSelected(RecommendedTagCellViewModel.self).asObservable(), photoCellSelected: photoCollectionView.rx.modelSelected(PhotoCellViewModel.self).asObservable(), selectedImages: imagePickerObservable.asObservable(), removeTargetItem: removeButtonTapTrigger.asObservable(), textViewDidBeginEditing: reviewTextView.rx.didBeginEditing.asObservable(), textViewDidEndEditing: reviewTextView.rx.didEndEditing.asObservable(), inputText: reviewTextView.rx.text)
        
        let output = viewModel.transform(input: input)
        
        output.secureTagCellItems
            .drive(secureTagCollectionView.rx.items(cellIdentifier: SecureTagCell.identifier, cellType: SecureTagCell.self)) { _, viewModel, cell in
                cell.bind(to: viewModel)
            }
            .disposed(by: disposeBag)
        
        output.recommendedTagCellItems
            .drive(recommendedTagCollectionView.rx.items(cellIdentifier: RecommendedTagCell.identifier, cellType: RecommendedTagCell.self)) { _, viewModel, cell in
                cell.bind(to: viewModel)
            }
            .disposed(by: disposeBag)
        
        output.photoCellItems
            .drive(photoCollectionView.rx.items(cellIdentifier: PhotoCell.identifier, cellType: PhotoCell.self)) { [unowned self] row, viewModel, cell in
                cell.disposeBag = DisposeBag()
                cell.bind(to: viewModel, removeButtonTapped: self.removeButtonTapTrigger, indexPath: row)
                self.photoCollectionView.updateCollectionViewHeight()
            }
            .disposed(by: disposeBag)

        output.presentPickerView
            .drive(onNext: { [unowned self] in
                self.setupImagePicker()
            })
            .disposed(by: disposeBag)
        
        output.attributedText
            .bind(to: reviewTextView.rx.attributedText)
            .disposed(by: disposeBag)
        
        output.textCount
            .bind(to: reviewTextCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        secureTagCollectionView.updateCollectionViewHeight()
        recommendedTagCollectionView.updateCollectionViewHeight()
    }
    
    func setupImagePicker(){
        // 피커뷰 설정 관련 인스턴스
        var configuration = PHPickerConfiguration()

        // The default value is 1. Setting the value to 0 sets the selection limit to the maximum that the system supports.
        // 디폴트는 1개를 가져올 수 있고 0개 선택시 무한대로 가져올 수 있다고 함
        configuration.selectionLimit = 6

        // 애셋 타입을 지정한다. Live Photo 등을 가져올 수도 있음
        configuration.filter = .any(of: [.images])

        // 피커뷰 객체 생성 시 파라미터에 설정을 전달
        let picker = PHPickerViewController(configuration: configuration)

        // 델리게이트 지정
        picker.delegate = self

        // 화면에 띄우기
        present(picker, animated: true)
    }
    
    // MARK: - Objc Functions
    @objc
    func closeButtonTapped() {
        homeFlow.popToRootView()
    }
    
    @objc
    func scrollViewTapped(sender: UITapGestureRecognizer) {
        sender.view?.endEditing(true)
    }
}

extension RouteRegisterViewController: PHPickerViewControllerDelegate{
    // reload하면서 이미지 순서가 뒤바뀌는 문제 발생
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        // MARK: addImage도 포함해서 11개
        if(photoCollectionView.visibleCells.count + results.count > 6){
            let alert = UIAlertController(title: "사진 등록", message: "사진은 10장까지만 등록이 가능합니다.", preferredStyle: .alert)
            let success = UIAlertAction(title: "확인", style:.default)
            alert.addAction(success)
            
            present(alert, animated: true)
            return
        }
        
        // MARK: 이미지 로드를 안하고 dismiss를 하면 비동기작업 자체를 실행하면 안됨
        if(results.count == 0){
            return
        }
        let itemProviders = results.map { $0.itemProvider }
        
        itemProviders.forEach { itemProvider in
            if(itemProvider.canLoadObject(ofClass: UIImage.self)){
                itemProvider.loadObject(ofClass: UIImage.self) {[weak self] image, _ in
                    if let image = image as? UIImage {
                        self?.imagePickerObservable.onNext(image)
                    }
                }
            }
        }
    }
}
