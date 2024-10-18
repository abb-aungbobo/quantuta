//
//  AppRouter.swift
//  Quantuta
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Auth
import Core
import Quotes
import UIKit

final class AppRouter {
    func getRootViewController() -> UIViewController {
        return SecureStorage.shared.get(key: .userToken) == nil ? LoginScene.create() : QotdScene.create()
    }
    
    private func setRootViewController(_ rootViewController: UIViewController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
        let window = sceneDelegate.window
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

// MARK: - QuotesRouter
extension AppRouter: QuotesRouter {
    func routeToQuoteSearch(from sourceViewController: UIViewController) {
        let destinationViewController = QuoteSearchScene.create()
        sourceViewController.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    func routeToLogin() {
        let rootViewController = LoginScene.create()
        setRootViewController(rootViewController)
    }
}

// MARK: - AuthRouter
extension AppRouter: AuthRouter {
    func routeToQotd() {
        let rootViewController = QotdScene.create()
        setRootViewController(rootViewController)
    }
}
