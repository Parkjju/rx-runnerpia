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
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() { }
}
