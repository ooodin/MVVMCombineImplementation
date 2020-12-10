//
//  CustomDataSourceCellItem.swift
//  MVVMCombineImplementation
//
//  Created by Artem Semavin on 09.12.2020.
//

import Foundation

struct CustomDataSourceCellItem {
    let id: String
    let title: String
}

// MARK: Hashable

extension CustomDataSourceCellItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: Equatable

extension CustomDataSourceCellItem: Equatable {
    static func == (lhs: CustomDataSourceCellItem, rhs: CustomDataSourceCellItem) -> Bool {
        return lhs.id == rhs.id &&
            lhs.title == rhs.title
    }
}

