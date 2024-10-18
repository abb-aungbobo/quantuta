//
//  QuoteRepository.swift
//
//
//  Created by Aung Bo Bo on 11/05/2024.
//

import Foundation

public protocol QuoteRepository {
    func getQuoteOfTheDay() async throws -> Qotd
    func getQuotes(filter: String) async throws -> QuoteList
}
