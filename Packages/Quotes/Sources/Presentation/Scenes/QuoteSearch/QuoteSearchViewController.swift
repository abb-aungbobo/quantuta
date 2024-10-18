//
//  QuoteSearchViewController.swift
//
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Core
import SnapKit
import UIKit

final public class QuoteSearchViewController: BaseViewController {
    private let searchBar = UISearchBar()
    private var collectionView: UICollectionView!
    
    private let viewModel: QuoteSearchViewModel
    
    public init(viewModel: QuoteSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        bind()
    }
    
    private func configureHierarchy() {
        configureView()
        configureNavigationItem()
        configureSearchBar()
        configureCollectionView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigationItem() {
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.titleView = searchBar
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
        searchBar.placeholder = "Search for Quotes"
        searchBar.autocapitalizationType = .none
        searchBar.returnKeyType = .default
        searchBar.becomeFirstResponder()
    }
    
    private func configureCollectionView() {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false
        let collectionViewLayout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(
            QuoteCollectionViewCell.self,
            forCellWithReuseIdentifier: QuoteCollectionViewCell.identifier
        )
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bind() {
        viewModel.state
            .sink { [weak self] state in
                self?.render(state: state)
            }
            .store(in: &viewModel.cancellables)
    }
    
    private func render(state: QuoteSearchViewModel.State) {
        switch state {
        case .idle:
            clearContentUnavailableConfiguration()
        case let .failed(error):
            clearContentUnavailableConfiguration()
            showErrorAlert(error: error)
        case .succeeded:
            if let searchText = searchBar.text, !searchText.isEmpty && viewModel.quotes.isEmpty {
                showEmptySearchResult()
            } else {
                clearContentUnavailableConfiguration()
            }
            collectionView.reloadData()
        }
    }
    
    private func showEmptySearchResult() {
        contentUnavailableConfiguration = UIContentUnavailableConfiguration.search()
        setNeedsUpdateContentUnavailableConfiguration()
    }
}

// MARK: - UISearchBarDelegate
extension QuoteSearchViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filter.send(searchText)
    }
}

// MARK: - UISearchTextFieldDelegate
extension QuoteSearchViewController: UISearchTextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()
        return true
    }
}

// MARK: - UICollectionViewDataSource
extension QuoteSearchViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.quotes.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: QuoteCollectionViewCell.identifier,
            for: indexPath
        ) as! QuoteCollectionViewCell
        let configuration = viewModel.quotes[indexPath.item].toQuoteContentConfiguration()
        cell.configuration = configuration
        return cell
    }
}
