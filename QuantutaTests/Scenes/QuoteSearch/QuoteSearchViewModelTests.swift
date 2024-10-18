//
//  QuoteSearchViewModelTests.swift
//  QuantutaTests
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Quotes
import XCTest

final class QuoteSearchViewModelTests: XCTestCase {
    private var sut: QuoteSearchViewModel!
    private let filter = "life"
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let quoteRepository: QuoteRepository = QuoteRepositoryStub()
        sut = QuoteSearchViewModel(quoteRepository: quoteRepository)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_state_whenSearchQuotes_shouldBeIdleAndSucceeded() async {
        let expected: [QuoteSearchViewModel.State] = [.idle, .succeeded]
        var results: [QuoteSearchViewModel.State] = []
        
        sut.state
            .sink { state in
                results.append(state)
            }
            .store(in: &sut.cancellables)
        
        await sut.searchQuotes(filter: filter)
        
        XCTAssert(expected == results, "Results expected to be \(expected) but were \(results)")
    }
    
    func test_quotes_whenSearchQuotes_shouldNotBeEmpty() async {
        await sut.searchQuotes(filter: filter)
        XCTAssertFalse(sut.quotes.isEmpty)
    }
}
