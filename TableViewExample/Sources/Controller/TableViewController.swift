//
//  TableViewController.swift
//  MVPImplementation
//
//  Created by Artem Semavin on 03.12.2020.
//

import UIKit
import Combine
import SnapKit

typealias DataSource = UITableViewDiffableDataSource<SectionItem, CellItem>
typealias Snapshot = NSDiffableDataSourceSnapshot<SectionItem, CellItem>

public final class TableViewController: UIViewController {
    var viewModel: TableViewModel?

    // MARK: - UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(TableViewCell.self)

        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        return tableView
    }()

    // MARK: - Private properties

    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(tableView: tableView) { [weak self] (tableView, indexPath, item) -> UITableViewCell? in
            self?.configureCell(tableView, indexPath: indexPath, item: item)
        }
        dataSource.defaultRowAnimation = .none
        return dataSource
    }()

    private var subscribtions = Set<AnyCancellable>()

    // MARK: - Life cycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()

        viewModel?.viewDidLoad()
    }

    // MARK: Private

    private func setupView() {
        tableView.dataSource = dataSource

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupBindings() {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.$title
            .receive(on: RunLoop.main)
            .sink { [weak self] title in
                self?.title = title
            }
            .store(in: &subscribtions)

        viewModel.$items
            .receive(on: RunLoop.main)
            .sink { [weak self] items in
                self?.update(items: items)
            }
            .store(in: &subscribtions)
    }

    private func update(items: [CellItem]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)

        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }

    private func configureCell(_ tableView: UITableView, indexPath: IndexPath, item: CellItem) -> UITableViewCell? {
        let cell: TableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.title = item.title
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TableViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
}

// MARK: - Private extensions

private extension UITableView {
    func register<T>(_ type: T.Type) where T: UITableViewCell {
        let identifier = String(describing: T.self)
        self.register(T.self, forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T where T: UITableViewCell {
        let identifier = String(describing: T.self)
        let defaultCell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        guard let cell = defaultCell as? T else {
            fatalError()
        }
        return cell
    }
}
