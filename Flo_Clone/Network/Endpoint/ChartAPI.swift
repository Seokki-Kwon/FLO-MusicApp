//
//  ChartAPI.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/26/25.
//

import Alamofire
import Foundation

enum ChartAPI {
    case fetchCategory(category: String)
}

extension ChartAPI: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = baseURL
                
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
                
        let encoding = URLEncoding.default
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    
    var baseURL: URL {
        return URL(string: "http://127.0.0.1:3000/top100")!
    }
    
    var path: String {
           switch self {
           case let .fetchCategory(category):
               return "/\(category)"
           }
       }
    
    var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchCategory:
            return .get
        }
    }
}
