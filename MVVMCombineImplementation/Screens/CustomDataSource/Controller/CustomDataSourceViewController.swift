//
//  CustomDataSourceViewController.swift
//  MVVMCombineImplementation
//
//  Created by Artem Semavin on 09.12.2020.
//

import UIKit
import SnapKit
import Combine

private typealias DataSource = CustomDataSource
private typealias Snapshot = NSDiffableDataSourceSnapshot<CustomDataSourceSection, CustomDataSourceCellItem>

final class CustomDataSourceViewController: UIViewController {

    var viewModel: CustomDataSourceViewModel?

    // MARK: - UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self)

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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()

        viewModel?.viewDidLoad()
    }

    // MARK: Private

    private func setupView() {
        dataSource.viewModel = viewModel
        tableView.dataSource = dataSource

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupBindings() {
        guard let viewModel = viewModel else {
            assertionFailure()
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

    private func update(items: [CustomDataSourceCellItem]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)

        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }

    private func configureCell(_ tableView: UITableView, indexPath: IndexPath, item: CustomDataSourceCellItem) -> UITableViewCell? {
        let cell: UITableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = item.title
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CustomDataSourceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
