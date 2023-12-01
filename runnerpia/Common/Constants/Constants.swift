//
//  Constants.swift
//  runnerpia
//
//  Created by 박경준 on 12/2/23.
//

import Foundation

struct K {
    /// API base URL
    static let baseUrl = "http://43.202.227.131:8080"
    
    /// 리퀘스트 바디 파라미터의 키값을 문자열로 사용할때 직접 추가
    struct Parameters {
        static let userId = "userId"
    }
    
    /// 헤더 필드
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    /// 컨텐츠 타입
    enum ContentType: String {
        case json = "application/json"
    }
}
