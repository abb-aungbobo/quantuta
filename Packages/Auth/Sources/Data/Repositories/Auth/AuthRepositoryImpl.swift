//
//  AuthRepositoryImpl.swift
//
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Core
import Extensions

final public class AuthRepositoryImpl: AuthRepository, CoreAuthRepository {
    private let networkController: NetworkController
    
    public init(networkController: NetworkController) {
        self.networkController = networkController
    }
    
    public func login(request: LoginRequest) async throws -> Login {
        let endpoint: SessionEndpoint = .login(request)
        let response: LoginResponse = try await networkController.request(for: endpoint)
        return response.toLogin()
    }
    
    public func logout() async throws -> Logout {
        let endpoint: SessionEndpoint = .logout
        let response: LogoutResponse = try await networkController.request(for: endpoint)
        return response.toLogout()
    }
}
