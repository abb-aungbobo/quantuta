//
//  QotdViewController.swift
//
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Core
import SnapKit
import UIKit

final public class QotdViewController: BaseViewController {
    private var logoutBarButtonItem: UIBarButtonItem!
    private var searchBarButtonItem: UIBarButtonItem!
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private let viewModel: QotdViewModel
    private let router: QuotesRouter
    
    public init(viewModel: QotdViewModel, router: QuotesRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        bind()
        
        Task {
            await viewModel.getQotd()
        }
    }
    
    private func configureHierarchy() {
        configureView()
        configureLogoutBarButtonItem()
        configureSearchBarButtonItem()
        configureNavigationItem()
        configureTableView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureLogoutBarButtonItem() {
        let logoutAction = UIAction { [weak self] action in
            self?.showLogoutAlert()
        }
        logoutBarButtonItem = UIBarButtonItem(title: "Logout", primaryAction: logoutAction)
    }
    
    private func configureSearchBarButtonItem() {
        let searchImage = UIImage(systemName: "magnifyingglass")
        let searchAction = UIAction { [weak self] action in
            guard let self else { return }
            self.router.routeToQuoteSearch(from: self)
        }
        searchBarButtonItem = UIBarButtonItem(image: searchImage, primaryAction: searchAction)
    }
    
    private func configureNavigationItem() {
        navigationItem.title = viewModel.title
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.leftBarButtonItem = logoutBarButtonItem
        navigationItem.rightBarButtonItem = searchBarButtonItem
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.register(
            QuoteTableViewCell.self,
            forCellReuseIdentifier: QuoteTableViewCell.identifier
        )
        tableView.register(
            QotdHeaderView.self,
            forHeaderFooterViewReuseIdentifier: QotdHeaderView.identifier
        )
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    private func bind() {
        viewModel.state
            .sink { [weak self] state in
                self?.render(state: state)
            }
            .store(in: &viewModel.cancellables)
    }
    
    private func render(state: QotdViewModel.State) {
        switch state {
        case .idle:
            clearContentUnavailableConfiguration()
        case .loading:
            showLoading()
        case let .failed(error):
            clearContentUnavailableConfiguration()
            showErrorAlert(error: error)
        case .succeeded:
            clearContentUnavailableConfiguration()
            tableView.reloadData()
        case .loggedout:
            router.routeToLogin()
        }
    }
    
    private func showLogoutAlert() {
        let title = "Logout"
        let message = "Are you sure you want to logout?"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(cancel)
        let logout = UIAlertAction(title: "Logout", style: .default) { [weak self] action in
            self?.logout()
        }
        alertController.addAction(logout)
        present(alertController, animated: true)
    }
    
    private func logout() {
        Task {
            await viewModel.logout()
        }
    }
}

// MARK: - UITableViewDataSource
extension QotdViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.qotd == nil ? 0 : 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: QuoteTableViewCell.identifier,
            for: indexPath
        ) as! QuoteTableViewCell
        let configuration = viewModel.qotd?.toQuoteContentConfiguration()
        cell.configuration = configuration
        return cell
    }
}

// MARK: - UITableViewDelegate
extension QotdViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.qotd == nil ? 0 : UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard viewModel.qotd != nil else { return nil }
        let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: QotdHeaderView.identifier
        ) as! QotdHeaderView
        return view
    }
}
