//
//  ExampleListTableViewItem.swift
//  MVPImplementation
//
//  Created by Artem Semavin on 03.12.2020.
//

import Foundation

struct ExampleListTableViewItem {
    let id: String
    let title: String
}

// MARK: Hashable

extension ExampleListTableViewItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: Equatable

extension ExampleListTableViewItem: Equatable {
    static func == (lhs: ExampleListTableViewItem, rhs: ExampleListTableViewItem) -> Bool {
        return lhs.id == rhs.id &&
            lhs.title == rhs.title
    }
}
