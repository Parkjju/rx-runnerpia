//
//  TabBarCoordinator.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/11.
//

import UIKit

enum TabBarPage {
    case followRoute
    case home
    case myPage

    init?(index: Int) {
        switch index {
        case 0:
            self = .followRoute
        case 1:
            self = .home
        case 2:
            self = .myPage
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .followRoute:
            return "경로 따라가기"
        case .home:
            return ""
        case .myPage:
            return "마이"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .followRoute:
            return 0
        case .home:
            return 1
        case .myPage:
            return 2
        }
    }

    // Add tab icon value
    func getIcon() -> UIImage {
        switch self {
        case .followRoute:
            return ImageLiteral.imgFollowRoute
        case .home:
            return ImageLiteral.imgHomeButton.withRenderingMode(.alwaysOriginal)
        case .myPage:
            return ImageLiteral.imgMyPage
        }
    }
    
    // Add tab icon selected / deselected color
    func getSelectedIcon() -> UIImage {
        switch self {
        case .followRoute:
            return ImageLiteral.imgFollowRoute.withRenderingMode(.alwaysOriginal)
        case .home:
            return ImageLiteral.imgHomeButton.withRenderingMode(.alwaysOriginal)
        case .myPage:
            return ImageLiteral.imgMyPage.withRenderingMode(.alwaysOriginal)
        }
    }
}

protocol TabCoordinatorProtocol: NSObject, Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

class TabBarCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    func start() {
        let pages: [TabBarPage] = [.followRoute, .home, .myPage].sorted(by: {$0.pageOrderNumber() < $1.pageOrderNumber()})
        
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        prepareTabBarController(withTabControllers: controllers)
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        
        /// Set delegate for UITabBarController
        tabBarController.delegate = self
        /// Assign page's controllers
        tabBarController.setViewControllers(tabControllers, animated: true)
        /// Let set index
        tabBarController.selectedIndex = TabBarPage.home.pageOrderNumber()
        /// Styling
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.layer.masksToBounds = false
        tabBarController.tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBarController.tabBar.layer.shadowOpacity = 0.1
        tabBarController.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBarController.tabBar.layer.shadowRadius = 6
        
        /// image
        guard let items = tabBarController.tabBar.items else { return }
        items[0].image = ImageLiteral.imgFollowRoute
        items[0].selectedImage = ImageLiteral.imgFollowRoute.withRenderingMode(.alwaysOriginal)
        items[0].title = "경로 따라가기"
        items[1].image = ImageLiteral.imgHomeButton.resize(to: CGSize(width: 58, height: 58)).withRenderingMode(.alwaysOriginal)
        items[1].selectedImage = ImageLiteral.imgHomeButton.resize(to: CGSize(width: 58, height: 58)).withRenderingMode(.alwaysOriginal)
        items[2].image = ImageLiteral.imgMyPage
        items[2].selectedImage = ImageLiteral.imgMyPage.withRenderingMode(.alwaysOriginal)
        items[2].title = "마이"
        
        /// In this step, we attach tabBarController to navigation controller associated with this coordanator
        navigationController.viewControllers = [tabBarController]
    }
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
           let navController = UINavigationController()
           navController.setNavigationBarHidden(false, animated: false)

           navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                        image: nil,
                                                        tag: page.pageOrderNumber())

           switch page {
           case .followRoute:
               // If needed: Each tab bar flow can have it's own Coordinator.
               let followRouteVC = RouteFollowingViewController()
               navController.pushViewController(followRouteVC, animated: true)
           case .home:
               let homeVC = HomeViewController()
               homeVC.coordinator = HomeCoordinator(navigationController: self.navigationController)
               childCoordinators.append(homeVC.coordinator!)
               navController.pushViewController(homeVC, animated: true)
           case .myPage:
               let myPageVC = MyPageViewController()
               navController.pushViewController(myPageVC, animated: true)
           }
           
           return navController
       }
}

extension TabBarCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        // Some implementation
    }
}
