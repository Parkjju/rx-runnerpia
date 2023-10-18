//
//  RouteFollowingCoordinator.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/11.
//

import UIKit

class RouteRegisterCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let followRouteVC = RouteRegisterViewController()
        navigationController.pushViewController(followRouteVC, animated: true)
    }
}
