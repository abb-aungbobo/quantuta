//
//  AuthRepositoryStub.swift
//  
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Core
import Utilities

final public class AuthRepositoryStub: AuthRepository, CoreAuthRepository {
    
    public init() {}
    
    public func login(request: LoginRequest) async throws -> Login {
        let response: LoginResponse = try JSON.decode(from: "login", bundle: .auth)
        return response.toLogin()
    }
    
    public func logout() async throws -> Logout {
        let response: LogoutResponse = try JSON.decode(from: "logout", bundle: .auth)
        return response.toLogout()
    }
}
