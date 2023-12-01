//
//  AppDelegate.swift
//  runnerpia
//
//  Created by 박경준 on 2023/09/27.
//

import UIKit
import RxKakaoSDKCommon
import RxKakaoSDKAuth
import KakaoSDKAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /// 카카오 셋업
        if let kakaoKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_KEY") as? String {
            RxKakaoSDK.initSDK(appKey: kakaoKey)
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }
        
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        
        window.rootViewController = navigationController
        
        let coordinator = AppCoordinator(navigationController: navigationController)
        navigationController.pushViewController(LoginViewController(viewModel: LoginViewModel()), animated: true)
        coordinator.start()
        
//        let tabbarCoordinator = TabBarCoordinator(navigationController: navigationController)
//        coordinator.childCoordinators.append(tabbarCoordinator)
//        coordinator.childCoordinators.first!.start()
        
        window.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.rx.handleOpenUrl(url: url)
        }

        return false
    }
}

