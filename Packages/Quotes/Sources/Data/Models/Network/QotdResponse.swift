//
//  QotdResponse.swift
//
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Foundation

struct QotdResponse: Codable {
    let quote: QuoteResponse
}

extension QotdResponse {
    func toQotd() -> Qotd {
        return Qotd(quote: quote.toQuote())
    }
}
