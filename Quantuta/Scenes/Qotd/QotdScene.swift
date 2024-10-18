//
//  QotdScene.swift
//  Quantuta
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Auth
import Core
import Quotes

enum QotdScene {
    static func create() -> QotdViewController {
        let networkController: NetworkController = NetworkControllerImpl.shared
        let quoteRepository: QuoteRepository = QuoteRepositoryImpl(networkController: networkController)
        let authRepository: CoreAuthRepository = AuthRepositoryImpl(networkController: networkController)
        let viewModel = QotdViewModel(quoteRepository: quoteRepository, authRepository: authRepository)
        let router: QuotesRouter = AppRouter()
        let viewController = QotdViewController(viewModel: viewModel, router: router)
        return viewController
    }
}
