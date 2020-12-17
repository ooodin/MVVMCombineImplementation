//
//  ViewController.swift
//  MVPImplementation
//
//  Created by Artem Semavin on 03.12.2020.
//

import UIKit
import Combine
import SnapKit
import Common

typealias DataSource = UITableViewDiffableDataSource<SectionItem, CellItem>
typealias Snapshot = NSDiffableDataSourceSnapshot<SectionItem, CellItem>

public final class ViewController: UIViewController {

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
    private let analytics: Analytics
    private let viewModel: ViewModel

    // MARK: - Initializers

    init(analytics: Analytics, viewModel: ViewModel) {
        self.viewModel = viewModel
        self.analytics = analytics

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()

        viewModel.viewDidLoad()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        analytics.sendEvent(name: "Table view did appear")
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

extension ViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        analytics.sendEvent(name: "Cell did select at: \(indexPath.row)")
    }
}
