//
//  CustomDataSource.swift
//  MVVMCombineImplementation
//
//  Created by Artem Semavin on 09.12.2020.
//

import UIKit

final class CustomDataSource: UITableViewDiffableDataSource<CustomDataSourceSection, CustomDataSourceCellItem> {
    weak var viewModel: CustomDataSourceViewModel?

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            viewModel?.didPressDelete(at: indexPath.row)
        default:
            break
        }
    }
}

