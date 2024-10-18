//
//  Quote.swift
//
//
//  Created by Aung Bo Bo on 11/05/2024.
//

import Foundation

public struct Quote: Equatable {
    let id: Int
    let favoritesCount: Int
    let author: String?
    let body: String
}

extension Quote {
    static func fixture(
        id: Int = 0,
        favoritesCount: Int = 0,
        author: String? = "",
        body: String = ""
    ) -> Quote {
        return Quote(
            id: id,
            favoritesCount: favoritesCount,
            author: author,
            body: body
        )
    }
    
    static let noQuotesFound = Quote(
        id: 0,
        favoritesCount: 0,
        author: nil,
        body: "No quotes found"
    )
}
