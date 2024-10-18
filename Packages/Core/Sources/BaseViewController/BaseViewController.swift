//
//  BaseViewController.swift
//
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import UIKit

open class BaseViewController: UIViewController {
    public func clearContentUnavailableConfiguration() {
        contentUnavailableConfiguration = nil
        setNeedsUpdateContentUnavailableConfiguration()
    }
    
    public func showLoading() {
        contentUnavailableConfiguration = UIContentUnavailableConfiguration.loading()
        setNeedsUpdateContentUnavailableConfiguration()
    }
    
    public func showErrorAlert(error: AppError) {
        let alertController = UIAlertController(title: "Oops!", message: error.localizedDescription, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel)
        alertController.addAction(dismiss)
        present(alertController, animated: true)
    }
}
