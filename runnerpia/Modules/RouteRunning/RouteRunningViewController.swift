//
//  RouteRunningViewController.swift
//  runnerpia
//
//  Created by Jun on 2023/10/10.
//

import UIKit
import CoreLocation
import NMapsMap

class RouteRunningViewController: BaseViewController {
    
    // MARK: - Subviews
    let mapView = NMFMapView()
    
    // MARK: - Properties
    var viewModel: RouteRunningViewModel
    
    // MARK: - Life Cycles
    init(viewModel: RouteRunningViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    override func render() {
        view.addSubViews([mapView])
        
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
    }
}
