//
//  NetworkControllerImpl.swift
//
//
//  Created by Aung Bo Bo on 11/05/2024.
//

import Alamofire
import Foundation

final public class NetworkControllerImpl: NetworkController {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    public static let shared = NetworkControllerImpl()
    
    public init() {}
    
    public func request<T: Codable>(for endpoint: Endpoint) async throws -> T {
        return try await AF
            .request(
                endpoint,
                method: endpoint.method,
                parameters: endpoint.parameters,
                encoding: endpoint.encoding,
                headers: endpoint.headers
            )
            .validate()
            .serializingDecodable(T.self)
            .value
    }
}
