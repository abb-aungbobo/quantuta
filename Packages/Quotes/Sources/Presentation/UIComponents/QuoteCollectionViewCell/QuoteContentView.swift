//
//  QuoteContentView.swift
//  
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Extensions
import SnapKit
import UIKit

final class QuoteContentView: UIView, UIContentView {
    private let bodyLabel = UILabel()
    private let authorLabel = UILabel()
    private let favoriteImageView = UIImageView()
    private let favoritesCountLabel = UILabel()
    
    private var appliedConfiguration: QuoteContentConfiguration!
    
    var configuration: UIContentConfiguration {
        get { appliedConfiguration }
        set {
            guard let newConfig = newValue as? QuoteContentConfiguration else { return }
            apply(configuration: newConfig)
        }
    }
    
    init(configuration: QuoteContentConfiguration) {
        super.init(frame: .zero)
        configureHierarchy()
        apply(configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        configureView()
        configureBodyLabel()
        configureAuthorLabel()
        configureFavoriteImageView()
        configureFavoritesCountLabel()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
    }
    
    private func configureBodyLabel() {
        addSubview(bodyLabel)
        bodyLabel.adjustsFontForContentSizeCategory = true
        bodyLabel.font = .preferredFont(forTextStyle: .headline)
        bodyLabel.numberOfLines = 0
        bodyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func configureAuthorLabel() {
        addSubview(authorLabel)
        authorLabel.adjustsFontForContentSizeCategory = true
        authorLabel.font = .preferredFont(forTextStyle: .subheadline)
        authorLabel.textColor = .secondaryLabel
        authorLabel.numberOfLines = 0
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(bodyLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func configureFavoriteImageView() {
        addSubview(favoriteImageView)
        favoriteImageView.image = UIImage(systemName: "heart")
        favoriteImageView.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-8)
            make.width.height.equalTo(16)
        }
    }
    
    private func configureFavoritesCountLabel() {
        addSubview(favoritesCountLabel)
        favoritesCountLabel.adjustsFontForContentSizeCategory = true
        favoritesCountLabel.font = .preferredFont(forTextStyle: .footnote)
        favoritesCountLabel.textColor = .tertiaryLabel
        favoritesCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(favoriteImageView.snp.trailing).offset(4)
            make.centerY.equalTo(favoriteImageView)
        }
    }
    
    private func apply(configuration: QuoteContentConfiguration) {
        guard appliedConfiguration != configuration else { return }
        appliedConfiguration = configuration
        
        bodyLabel.text = configuration.body
        authorLabel.text = configuration.author
        favoritesCountLabel.text = configuration.favoritesCount
    }
}
