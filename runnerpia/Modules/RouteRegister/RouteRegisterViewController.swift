//
//  RouteRegisterViewController.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/13.
//

import UIKit
import NMapsMap
import RxSwift

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
    
    let reviewLabel = UILabel()
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
    
    // MARK: - Properties
    var viewModel: RouteRegisterViewModel
    var homeFlow: HomeFlow
    
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
        
        scrollView.subviews.first!.addSubViews([mapView, completeLabel, locationView, dateView, timeView, distanceView, divider, reviewLabel, secureTagLabel, secureTagCollectionView, recommendedTagLabel, recommendedTagCollectionView])
        
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
        
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(20)
            make.leading.equalTo(mapView)
        }
        
        secureTagLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewLabel.snp.bottom).offset(16)
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
            make.bottom.equalTo(scrollView.snp.bottom).offset(-20)
        }
    }
    
    override func configUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "러닝 내역"
        
        let rightBarButtonItem = UIBarButtonItem(image: ImageLiteral.imgClose.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    override func bindViewModel() {
        let input = RouteRegisterViewModel.Input(secureTagSelected: secureTagCollectionView.rx.modelSelected(SecureTagCell.self).asObservable(), recommendedTagSelected: recommendedTagCollectionView.rx.modelSelected(RecommendedTagCell.self).asObservable())
        
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
        
        secureTagCollectionView.updateCollectionViewHeight()
        recommendedTagCollectionView.updateCollectionViewHeight()
        
        
    }
    
    // MARK: - Objc Functions
    @objc
    func closeButtonTapped() {
        homeFlow.popToRootView()
    }
}
