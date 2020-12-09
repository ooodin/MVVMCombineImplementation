//
//  TableViewCell.swift
//  
//
//  Created by Artem Semavin on 08.12.2020.
//

import UIKit
import SnapKit

final class TableViewCell: UITableViewCell {

    var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }

    // MARK: - UI

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Style.font
        return label
    }()

    // MARK: - Life cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func setupView() {
        contentView.layoutMargins = Style.contentViewInsets

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView.layoutMargins)
        }
    }
}

// MARK: - Style

private extension TableViewCell {
    enum Style {
        static let contentViewInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        static let font: UIFont = .systemFont(ofSize: 19, weight: .semibold)
    }
}
