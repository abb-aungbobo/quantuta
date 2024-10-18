//
//  LoginScene.swift
//  Quantuta
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Auth
import Core

enum LoginScene {
    static func create() -> LoginViewController {
        let networkController: NetworkController = NetworkControllerImpl.shared
        let authRepository: AuthRepository = AuthRepositoryImpl(networkController: networkController)
        let viewModel = LoginViewModel(authRepository: authRepository)
        let router: AuthRouter = AppRouter()
        let viewController = LoginViewController(viewModel: viewModel, router: router)
        return viewController
    }
}
