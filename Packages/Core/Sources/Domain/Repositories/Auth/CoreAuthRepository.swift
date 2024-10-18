//
//  CoreAuthRepository.swift
//  
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Foundation

public protocol CoreAuthRepository {
    func logout() async throws -> Logout
}
