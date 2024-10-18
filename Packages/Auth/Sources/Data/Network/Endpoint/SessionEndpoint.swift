//
//  SessionEndpoint.swift
//  
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Alamofire
import Core
import Foundation

enum SessionEndpoint: Endpoint {
    case login(LoginRequest)
    case logout
    
    var path: String {
        switch self {
        case .login:
            return "session"
        case .logout:
            return "session"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .logout:
            return .delete
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .login(request):
            return request.dictionary
        default:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .login:
            return URLEncoding.httpBody
        default:
            return URLEncoding.default
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Authorization": Environment.apiKey]
    }
    
    func asURL() throws -> URL {
        return Environment.apiBaseURL.appendingPathComponent(path)
    }
}
