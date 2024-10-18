//
//  LogoutResponse.swift
//
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Core

struct LogoutResponse: Codable {
    let message: String
}

extension LogoutResponse {
    func toLogout() -> Logout {
        return Logout(message: message)
    }
}
