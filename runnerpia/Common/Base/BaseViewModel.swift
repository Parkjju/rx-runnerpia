//
//  BaseViewModel.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/10.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
