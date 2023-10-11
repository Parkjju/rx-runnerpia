//
//  RouteRunningViewController.swift
//  runnerpia
//
//  Created by Jun on 2023/10/10.
//

import UIKit

class RouteRunningViewController: BaseViewController {
    
    // MARK: - Subviews
    
    // MARK: - Properties
    
    // MARK: - Life Cycles
    
    // MARK: - Functions
    
    override func render() {
        print("ROUTE..")
    }
    
    override func configUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
    }
}
