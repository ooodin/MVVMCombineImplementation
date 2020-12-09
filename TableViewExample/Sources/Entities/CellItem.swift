//
//  CellItem.swift
//  MVPImplementation
//
//  Created by Artem Semavin on 03.12.2020.
//

import Foundation

struct CellItem {
    let id: String
    let title: String
}

// MARK: Hashable

extension CellItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: Equatable

extension CellItem: Equatable {
    static func == (lhs: CellItem, rhs: CellItem) -> Bool {
        return lhs.id == rhs.id &&
            lhs.title == rhs.title
    }
}
