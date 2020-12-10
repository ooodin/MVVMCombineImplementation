//
//  CustomDataSourceViewModel.swift
//  MVVMCombineImplementation
//
//  Created by Artem Semavin on 09.12.2020.
//

import Foundation
import Combine

final class CustomDataSourceViewModel {
    @Published private(set) var title: String?
    @Published private(set) var items: [CustomDataSourceCellItem] = []

    func viewDidLoad() {
        title = "Custom data source example"

        items = [
            CustomDataSourceCellItem(id: "0", title: "Try to delete cell1"),
            CustomDataSourceCellItem(id: "0", title: "Try to delete cell2"),
            CustomDataSourceCellItem(id: "0", title: "Try to delete cell3"),
        ]
    }

    // MARK: - Public

    func didPressDelete(at index: Int) {
        guard items.indices.contains(index) else {
            return
        }
        items.remove(at: index)
    }
}

