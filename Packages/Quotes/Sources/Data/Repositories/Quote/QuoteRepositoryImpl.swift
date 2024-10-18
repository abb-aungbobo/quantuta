//
//  QuoteRepositoryImpl.swift
//
//
//  Created by Aung Bo Bo on 11/05/2024.
//

import Core

final public class QuoteRepositoryImpl: QuoteRepository {
    private let networkController: NetworkController
    
    public init(networkController: NetworkController) {
        self.networkController = networkController
    }
    
    public func getQuoteOfTheDay() async throws -> Qotd {
        let endpoint: QuotesEndpoint = .qotd
        let response: QotdResponse = try await networkController.request(for: endpoint)
        return response.toQotd()
    }
    
    public func getQuotes(filter: String) async throws -> QuoteList {
        let endpoint: QuotesEndpoint = .quotes(filter)
        let response: QuoteListResponse = try await networkController.request(for: endpoint)
        return response.toQuoteList()
    }
}
