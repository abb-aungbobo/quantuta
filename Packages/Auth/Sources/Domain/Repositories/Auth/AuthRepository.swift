//
//  AuthRepository.swift
//
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Foundation

public protocol AuthRepository {
    func login(request: LoginRequest) async throws -> Login
}
