//
//  HomeCoordinator.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/11.
//

import UIKit

enum HomeFlowScenes {
    case routeRunning
    case registerNewRoute
    case registerSubRoute
    case inputPathInfo
}

protocol HomeFlow {
    func push(scene: HomeFlowScenes)
    func pop()
    func popToRootView()
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
            navigationController.pushViewController(RouteRunningViewController(viewModel: RouteRunningViewModel(), homeFlow: self), animated: true)
        case .registerSubRoute:
            navigationController.pushViewController(RouteFollowingViewController(viewModel: RouteFollowingViewModel(), homeFlow: self), animated: true)
        case .registerNewRoute:
            navigationController.pushViewController(RoutePreviewViewController(viewModel: RouteRegisterViewModel(), homeFlow: self), animated: true)
        case .inputPathInfo:
            navigationController.pushViewController(RouteRegisterViewController(viewModel: RouteRegisterViewModel(), homeFlow: self), animated: true)
        }
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func popToRootView() {
        navigationController.popToRootViewController(animated: true)
    }
}
