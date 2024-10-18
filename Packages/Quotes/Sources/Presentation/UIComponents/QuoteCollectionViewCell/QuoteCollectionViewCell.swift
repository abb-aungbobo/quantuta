//
//  QuoteCollectionViewCell.swift
//
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import UIKit

final class QuoteCollectionViewCell: UICollectionViewCell {
    var configuration: QuoteContentConfiguration!
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var newConfiguration = QuoteContentConfiguration().updated(for: state)
        newConfiguration.favoritesCount = configuration.favoritesCount
        newConfiguration.author = configuration.author
        newConfiguration.body = configuration.body
        contentConfiguration = newConfiguration
    }
}
