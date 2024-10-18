//
//  QuoteListResponse.swift
//
//
//  Created by Aung Bo Bo on 11/05/2024.
//

import Foundation

struct QuoteListResponse: Codable {
    let quotes: [QuoteResponse]
}

extension QuoteListResponse {
    func toQuoteList() -> QuoteList {
        return QuoteList(quotes: quotes.toQuotes())
    }
}
