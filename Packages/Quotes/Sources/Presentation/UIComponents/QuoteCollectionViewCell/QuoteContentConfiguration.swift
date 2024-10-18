//
//  QuoteContentConfiguration.swift
//
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import UIKit

struct QuoteContentConfiguration: UIContentConfiguration, Hashable {
    var favoritesCount: String?
    var author: String?
    var body: String?
    
    func makeContentView() -> UIView & UIContentView {
        return QuoteContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> QuoteContentConfiguration {
        let updatedConfig = self
        return updatedConfig
    }
}

extension Quote {
    func toQuoteContentConfiguration() -> QuoteContentConfiguration {
        let favoritesCount = favoritesCount > 1 ? String(format: "%d favs", favoritesCount) : String(format: "%d fav", favoritesCount)
        return QuoteContentConfiguration(
            favoritesCount: favoritesCount,
            author: author,
            body: body
        )
    }
}
