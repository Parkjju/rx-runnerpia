//
//  AuthenticationCoordinator.swift
//  runnerpia
//
//  Created by 박경준 on 12/1/23.
//

import UIKit

class AuthenticationCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() { }
}
