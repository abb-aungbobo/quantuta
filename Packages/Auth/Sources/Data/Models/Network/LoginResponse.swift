//
//  LoginResponse.swift
//
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Foundation

struct LoginResponse: Codable {
    let userToken: String
    let login: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case userToken = "User-Token"
        case login
        case email
    }
}

extension LoginResponse {
    func toLogin() -> Login {
        return Login(
            userToken: userToken,
            login: login,
            email: email
        )
    }
}
