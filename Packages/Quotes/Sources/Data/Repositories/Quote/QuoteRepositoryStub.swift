//
//  QuoteRepositoryStub.swift
//
//
//  Created by Aung Bo Bo on 11/05/2024.
//

import Utilities

final public class QuoteRepositoryStub: QuoteRepository {
    
    public init() {}
    
    public func getQuoteOfTheDay() async throws -> Qotd {
        let response: QotdResponse = try JSON.decode(from: "qotd", bundle: .quotes)
        return response.toQotd()
    }
    
    public func getQuotes(filter: String) async throws -> QuoteList {
        let response: QuoteListResponse = try JSON.decode(from: "quotes", bundle: .quotes)
        return response.toQuoteList()
    }
}
