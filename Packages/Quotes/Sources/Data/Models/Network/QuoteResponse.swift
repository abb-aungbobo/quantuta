//
//  QuoteResponse.swift
//
//
//  Created by Aung Bo Bo on 11/05/2024.
//

import Foundation

struct QuoteResponse: Codable {
    let id: Int
    let favoritesCount: Int
    let author: String?
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case favoritesCount = "favorites_count"
        case author
        case body
    }
}

extension QuoteResponse {
    func toQuote() -> Quote {
        return Quote(
            id: id,
            favoritesCount: favoritesCount,
            author: author,
            body: body
        )
    }
}

extension Array where Element == QuoteResponse {
    func toQuotes() -> [Quote] {
        return map { response in
            return response.toQuote()
        }
    }
}
