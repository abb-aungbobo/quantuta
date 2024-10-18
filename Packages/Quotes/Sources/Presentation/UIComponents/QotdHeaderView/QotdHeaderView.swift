//
//  QotdHeaderView.swift
//
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import SnapKit
import UIKit

final class QotdHeaderView: UITableViewHeaderFooterView {
    private let titleLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        configureView()
        configureTitleLabel()
    }
    
    private func configureView() {
        contentView.backgroundColor = .systemBackground
    }
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Quote of the Day"
        titleLabel.font = .preferredFont(forTextStyle: .title3, weight: .bold)
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}
