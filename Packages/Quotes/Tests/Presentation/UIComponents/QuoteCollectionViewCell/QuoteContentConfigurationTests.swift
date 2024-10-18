//
//  QuoteContentConfigurationTests.swift
//  
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import XCTest
@testable import Quotes

final class QuoteContentConfigurationTests: XCTestCase {
    func test_favoritesCount_withOne_shouldBeOneFav() {
        let quote = Quote.fixture(favoritesCount: 1)
        let configuration = quote.toQuoteContentConfiguration()
        XCTAssertEqual(configuration.favoritesCount, "1 fav")
    }
    
    func test_favoritesCount_withTwo_shouldBeTwoFavs() {
        let quote = Quote.fixture(favoritesCount: 2)
        let configuration = quote.toQuoteContentConfiguration()
        XCTAssertEqual(configuration.favoritesCount, "2 favs")
    }
}
