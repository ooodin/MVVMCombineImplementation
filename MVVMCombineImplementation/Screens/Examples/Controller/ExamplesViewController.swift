//
//  ExamplesViewController.swift
//  MVPImplementation
//
//  Created by Artem Semavin on 03.12.2020.
//

import UIKit
import Combine
import SnapKit
import RouteComposer

private typealias DataSource = UITableViewDiffableDataSource<ExamplesSectionItem, ExamplesCellItem>
private typealias Snapshot = NSDiffableDataSourceSnapshot<ExamplesSectionItem, ExamplesCellItem>

final class ExamplesViewController: UIViewController {

    var viewModel: ExamplesViewModel?

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

    private func update(items: [ExamplesCellItem]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)

        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }

    private func configureCell(_ tableView: UITableView, indexPath: IndexPath, item: ExamplesCellItem) -> UITableViewCell? {
        let cell: UITableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = item.title
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ExamplesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 0:
            try? router.navigate(to: ConfigurationHolder.configuration.tableViewScreen, animated: true, completion: nil)
        case 1:
            try? router.navigate(to: ConfigurationHolder.configuration.customDataSourceScreen, animated: true, completion: nil)
        default:
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
            let alert = UIAlertController(
                title: "Oooops",
                message: "There's still nothing here",
                preferredStyle: .alert
            )
            alert.addAction(action)

            navigationController?.present(alert, animated: true)
        }
    }
}
