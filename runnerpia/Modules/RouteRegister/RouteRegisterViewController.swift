//
//  RouteRegisterViewController.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/13.
//

import UIKit

class RouteRegisterViewController: BaseViewController {
    
    // MARK: - Subviews
    
    // MARK: - Properties
    var viewModel: RouteRegisterViewModel
    var homeFlow: HomeFlow
    
    // MARK: - Functions
    
    init(viewModel: RouteRegisterViewModel, homeFlow: HomeFlow) {
        self.viewModel = viewModel
        self.homeFlow = homeFlow
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configUI() {
        view.backgroundColor = .systemBackground
    }
    // MARK: - Objc Functions
}
