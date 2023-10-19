//
//  RouteInformation.swift
//  runnerpia
//
//  Created by Jun on 2023/10/18.
//

import UIKit

class RouteInformation: UIView {
    
    // MARK: - Subviews
    
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
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        render()
        configUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func render() {
        self.addSubViews([locationView, dateView, timeView, distanceView])
        
        locationView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        dateView.snp.makeConstraints { make in
            make.top.equalTo(locationView.snp.bottom).offset(16)
            make.leading.equalTo(locationView)
            make.height.equalTo(20)
        }
        
        timeView.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom).offset(10)
            make.leading.equalTo(locationView)
            make.height.equalTo(20)
        }
        
        distanceView.snp.makeConstraints { make in
            make.top.equalTo(timeView.snp.bottom).offset(10)
            make.leading.equalTo(locationView)
            make.height.equalTo(20)
        }
    }
    
    func configUI() {
        
    }
}
