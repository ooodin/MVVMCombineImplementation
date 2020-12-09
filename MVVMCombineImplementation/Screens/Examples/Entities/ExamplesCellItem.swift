//
//  ExamplesCellItem.swift
//  MVPImplementation
//
//  Created by Artem Semavin on 03.12.2020.
//

import Foundation

struct ExamplesCellItem {
    let id: String
    let title: String
}

// MARK: Hashable

extension ExamplesCellItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: Equatable

extension ExamplesCellItem: Equatable {
    static func == (lhs: ExamplesCellItem, rhs: ExamplesCellItem) -> Bool {
        return lhs.id == rhs.id &&
            lhs.title == rhs.title
    }
}
