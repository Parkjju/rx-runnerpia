//
//  APIError.swift
//  runnerpia
//
//  Created by 박경준 on 12/2/23.
//

import Foundation

enum APIError: Error {
    case decode
    case http(status: Int)
    case unknown
}

/// API 에러 스트링으로 변환
extension APIError: CustomStringConvertible {
    var description: String {
        switch self {
        case .decode:
            return "Decode Error"
        case let .http(status):
            return "HTTP Error: \(status)"
        case .unknown:
            return "Unknown Error"
        }
    }
}
