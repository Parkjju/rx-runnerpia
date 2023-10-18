# 러너피아

## 🎁 Library

| 라이브러리        | Version     |       |
| ----------------- | :-----:  | ----- |
| Then              | `3.0.0`  | `CocoaPods` |
| SnapKit           | `5.6.0`  | `CocoaPods` |
| RxSwift           | `6.6.0`  | `CocoaPods` |
| RxCocoa           | `6.6.0`  | `CocoaPods` |

## 🗂 Folder Structure
```text
runnerpia
├── Application
├── Common
│   ├── Base
│   ├── LocationManager
│   └── Tags
├── Configs
├── Extensions
│   ├── RxSwift
│   ├── UICollectionView
│   │   └── LeftAlignedCollectionView
│   ├── UIColor
│   ├── UIFont
│   ├── UIImage
│   └── UIView
├── Models
├── Modules
│   ├── Home
│   ├── Main
│   ├── My Page
│   ├── RouteDetail
│   ├── RouteFollowing
│   ├── RouteRegister
│   └── RouteRunning
├── Networking
└── Resources
    ├── Assets.xcassets
    └── Font
```
1. `Application` - 앱 엔트리포인트 관련 파일들 관리 (앱 코디네이터 & 앱 델리게이트)
2. `Common` - 공통 컴포넌트, 베이스 클래스, 각종 매니저 클래스, 열거형
3. `Configs` - 환경변수 파일
4. `Extensions` - 클래스 익스텐션 (Rx 델리게이트 프록시는 RxSwift 그룹 내에 관리)
5. `Models` - API 통신 모델
6. `Modules` - 스크린 단위별 그룹화
7. `Networking` - 각종 네트워킹 코드
8. `Resource` - 이미지 애셋, 폰트, info.plist, 이미지 리터럴 열거형

## 🛠️ Architecture
1. 아키텍쳐 패턴 - MVVM
2. Output & Input & transform

## 기존 MVC 프로젝트

[링크](https://github.com/Parkjju/runnerpia.git)
