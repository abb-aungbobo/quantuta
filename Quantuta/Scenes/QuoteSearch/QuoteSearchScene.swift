//
//  QuoteSearchScene.swift
//  Quantuta
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Core
import Quotes

enum QuoteSearchScene {
    static func create() -> QuoteSearchViewController {
        let networkController: NetworkController = NetworkControllerImpl.shared
        let quoteRepository: QuoteRepository = QuoteRepositoryImpl(networkController: networkController)
        let viewModel = QuoteSearchViewModel(quoteRepository: quoteRepository)
        let viewController = QuoteSearchViewController(viewModel: viewModel)
        return viewController
    }
}
