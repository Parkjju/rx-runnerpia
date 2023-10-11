//
//  HomeCoordinator.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/11.
//

import UIKit

enum HomeFlowScenes {
    case routeRunning
    case runningComplete
    case runningRegister
}

protocol HomeFlow {
    func push(scene: HomeFlowScenes)
    func pop()
}

class HomeCoordinator: Coordinator, HomeFlow {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    func push(scene: HomeFlowScenes) {
        switch scene {
        case .routeRunning:
            navigationController.pushViewController(RouteRunningViewController(), animated: true)
        case .runningComplete:
            navigationController.pushViewController(UIViewController(), animated: true)
        case .runningRegister:
            navigationController.pushViewController(UIViewController(), animated: true)
        }
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
}
