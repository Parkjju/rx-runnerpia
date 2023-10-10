//
//  AppCoordinator.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/10.
//

import UIKit

protocol Coordinator {
    var childCoordinators : [Coordinator] { get set }
    
    func start()
}

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = setTapBarController()
        self.navigationController.viewControllers = [viewController]
    }
    
    private func setTapBarController() -> UITabBarController {
        let tabBarViewController = TabBarController()

        let vc1 = UINavigationController(rootViewController: ViewController())
        let vc2 = UINavigationController(rootViewController: ViewController())
        let vc3 = UINavigationController(rootViewController: ViewController())

        tabBarViewController.setViewControllers([vc1, vc2, vc3], animated: false)
        tabBarViewController.modalPresentationStyle = .fullScreen
        tabBarViewController.tabBar.backgroundColor = .white
        tabBarViewController.tabBar.tintColor = .black

        guard let items = tabBarViewController.tabBar.items else { return UITabBarController() }
        items[0].image = UIImage(named: "route")
        items[0].selectedImage = UIImage(named: "route")?.withRenderingMode(.alwaysOriginal)
        items[0].title = "경로 따라가기"
        items[1].image = UIImage(named: "homeButton")
        items[1].selectedImage = UIImage(named: "homeButton")?.withRenderingMode(.alwaysOriginal)
        items[2].image = UIImage(named: "myPage")
        items[2].selectedImage = UIImage(named: "myPage")?.withRenderingMode(.alwaysOriginal)
        items[2].title = "마이"


        tabBarViewController.selectedIndex = 1
        tabBarViewController.tabBar.backgroundColor = .white
        tabBarViewController.tabBar.layer.masksToBounds = false
        tabBarViewController.tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBarViewController.tabBar.layer.shadowOpacity = 0.1
        tabBarViewController.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBarViewController.tabBar.layer.shadowRadius = 6
        
        return tabBarViewController
    }
}
