//
//  APIRouter.swift
//  runnerpia
//
//  Created by Jun on 2023/10/10.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    case login(userId: String)
    
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    private var path: String {
        switch self {
        case .login:
            return "/auth/login"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .login(let userId):
            return [K.Parameters.userId: userId]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try K.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        /// self의 method 속성을 참조
        urlRequest.httpMethod = method.rawValue
        
        /// 네트워크 통신 일반에 사용되는 헤더 기본추가
        urlRequest.setValue(K.ContentType.json.rawValue, forHTTPHeaderField: K.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(K.ContentType.json.rawValue, forHTTPHeaderField: K.HttpHeaderField.contentType.rawValue)
        
        /// 요청 바디 인코딩
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
}
