//
//  APIService.swift
//  runnerpia
//
//  Created by 박경준 on 12/2/23.
//

import Foundation

import Alamofire
import RxSwift

protocol APIService {
    func requestSingle<T: Codable> (_ request: APIRouter) -> Single<T>
}
