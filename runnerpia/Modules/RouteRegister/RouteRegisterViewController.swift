//
//  RouteFollowingViewController.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/10.
//

import UIKit
import NMapsMap

import RxSwift
import PhotosUI

/// 신 경로 등록 뷰
class RouteRegisterViewController: BaseViewController {
    
    // MARK: - Subviews
    
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
    
    let mapView = NMFMapView()
        .then {
            $0.layer.cornerRadius = 10 // MARK: mapView Radius -> 10
            $0.allowsScrolling = false
            $0.allowsRotating = false
            $0.allowsZooming = false
            $0.allowsTilting = false
        }
    
    let routeNameLabel = UILabel()
        .then {
            $0.font = .pretendard(.semibold, ofSize: 18)
            $0.text = "러닝 경로 이름"
        }
    
    let routeNameTextView = UITextField()
        .then {
            $0.layer.borderColor = UIColor.grey300.cgColor
            $0.layer.borderWidth = 1
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
            $0.font = .pretendard(.semibold, ofSize: 18)
            $0.setLeftPaddingPoints(16)
            $0.placeholder = "송정뚝방길 02"
        }
    
    let routeInformationLabel = UILabel()
        .then {
            $0.font = .pretendard(.semibold, ofSize: 18)
            $0.text = "경로 정보"
        }
    
    let routeInformationView = RouteInformation()
    
    let dividerUnderRouteInfo = UIImageView(image: ImageLiteral.imgDivider)
    
    let rateLabel = UILabel()
        .then {
            $0.font = .pretendard(.semibold, ofSize: 18)
            $0.text = "다녀오신 경로를 평가해주세요!"
        }
    
    let secureTagSelection = SecureTagSelection()
    
    let recommendedTagSelection = RecommendedTagSelection()
    
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
    
    let registerButton = UIButton(type: .system)
        .then {
            $0.setTitleColor(.white, for: .disabled)
            $0.setTitleColor(.white, for: .normal)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 20
            $0.titleLabel?.font = .pretendard(.semibold, ofSize: 18)
            $0.backgroundColor = .blue400
            $0.setTitle("작성 완료", for: .normal)
        }
    
    // MARK: - Properties
    var viewModel: RouteRegisterViewModel
    var homeFlow: HomeFlow
    
    let initialText = "최소 30자 이상 작성해주세요. (비방, 욕설을 포함한 관련없는 내용은 통보 없이 삭제될 수 있습니다.)"
    
    let imagePickerObservable = PublishSubject<UIImage>()
    let removeButtonTapTrigger = PublishSubject<Int>()
    
    // MARK: - Initialization
    
    init(viewModel: RouteRegisterViewModel, homeFlow: HomeFlow) {
        self.viewModel = viewModel
        self.homeFlow = homeFlow
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles
    
    // MARK: - Functions
    
    override func render() {
        view.addSubview(scrollView)
        
        scrollView.subviews.first!.addSubViews([mapView, routeNameLabel, routeNameTextView, routeInformationLabel, routeInformationView, dividerUnderRouteInfo, rateLabel, secureTagSelection, recommendedTagSelection, dividerUnderTags, reviewLabel, reviewTextView, reviewTextCountLabel, photoTextLabel, photoCollectionView, registerButton])
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.trailing.leading.equalTo(view)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.subviews.first!)
            make.leading.trailing.equalTo(view).inset(16)
            make.height.equalTo(180)
        }
        
        routeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.leading.equalTo(mapView)
        }
        
        routeNameTextView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(mapView)
            make.top.equalTo(routeNameLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
        
        routeInformationLabel.snp.makeConstraints { make in
            make.leading.equalTo(mapView)
            make.top.equalTo(routeNameTextView.snp.bottom).offset(20)
        }
        
        routeInformationView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(mapView)
            make.height.equalTo(116)
            make.top.equalTo(routeInformationLabel.snp.bottom).offset(20)
        }
        
        dividerUnderRouteInfo.snp.makeConstraints { make in
            make.top.equalTo(routeInformationView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(mapView)
        }
        
        rateLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerUnderRouteInfo.snp.bottom).offset(20)
            make.leading.equalTo(mapView)
        }
        
        secureTagSelection.snp.makeConstraints { make in
            make.top.equalTo(rateLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(mapView)
            make.height.equalTo(140) // MARK: tagSelection height -> 140
        }
        
        recommendedTagSelection.snp.makeConstraints { make in
            make.top.equalTo(secureTagSelection.snp.bottom).offset(20)
            make.leading.trailing.equalTo(mapView)
            make.height.equalTo(140)
        }
        
        dividerUnderTags.snp.makeConstraints { make in
            make.top.equalTo(recommendedTagSelection.snp.bottom)
            make.leading.trailing.equalTo(mapView)
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
            make.height.equalTo(80)
        }
        
        registerButton.snp.makeConstraints { make in
            make.bottom.equalTo(scrollView.snp.bottom).offset(-20)
            make.leading.trailing.equalTo(mapView)
            make.top.equalTo(photoCollectionView.snp.bottom).offset(50)
            make.height.equalTo(54)
        }
    }
    
    override func configUI() {
        self.navigationItem.title = "추천 경로 등록"
        view.backgroundColor = .white
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped))
        recognizer.numberOfTapsRequired = 1
        recognizer.isEnabled = true
        recognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(recognizer)
    }
    
    override func bindViewModel() {
        let input = RouteRegisterViewModel.Input(secureTagSelected: secureTagSelection.secureTagCollectionView.rx.modelSelected(SecureTagCellViewModel.self).asObservable(), recommendedTagSelected: recommendedTagSelection.recommendedTagCollectionView.rx.modelSelected(RecommendedTagCellViewModel.self).asObservable(), textViewDidBeginEditing: reviewTextView.rx.didBeginEditing.asObservable(), textViewDidEndEditing: reviewTextView.rx.didEndEditing.asObservable(), inputText: reviewTextView.rx.text, photoCellSelected: photoCollectionView.rx.modelSelected(PhotoCellViewModel.self).asObservable(), selectedImages: imagePickerObservable.asObservable(), removeTargetItem: removeButtonTapTrigger.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.secureTagCellItems
            .drive(secureTagSelection.secureTagCollectionView.rx.items(cellIdentifier: SecureTagCell.identifier, cellType: SecureTagCell.self)) { _, viewModel, cell in
                cell.bind(to: viewModel)
            }
            .disposed(by: disposeBag)
        
        output.recommendedTagCellItems
            .drive(recommendedTagSelection.recommendedTagCollectionView.rx.items(cellIdentifier: RecommendedTagCell.identifier, cellType: RecommendedTagCell.self)) { _, viewModel, cell in
                cell.bind(to: viewModel)
            }
            .disposed(by: disposeBag)
        
        output.attributedText
            .bind(to: reviewTextView.rx.attributedText)
            .disposed(by: disposeBag)
        
        output.textCount
            .bind(to: reviewTextCountLabel.rx.text)
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
        
        output.isEnabled
            .drive(onNext: { [unowned self] in
                if $0 {
                    self.registerButton.isEnabled = true
                    self.registerButton.backgroundColor = .blue400
                } else {
                    self.registerButton.isEnabled = false
                    self.registerButton.backgroundColor = .grey300
                }
            })
            .disposed(by: disposeBag)
        
        secureTagSelection.secureTagCollectionView.updateCollectionViewHeight()
        recommendedTagSelection.recommendedTagCollectionView.updateCollectionViewHeight()
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
    
    // MARK: - Objc functions
    
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
