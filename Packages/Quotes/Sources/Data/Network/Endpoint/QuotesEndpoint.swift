//
//  QuotesEndpoint.swift
//  
//
//  Created by Aung Bo Bo on 11/05/2024.
//

import Alamofire
import Core
import Foundation

enum QuotesEndpoint: Endpoint {
    case qotd
    case quotes(String)
    
    var path: String {
        switch self {
        case .qotd:
            return "qotd"
        case .quotes:
            return "quotes"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .qotd, .quotes:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .quotes(filter):
            return ["filter": filter]
        default:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
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
