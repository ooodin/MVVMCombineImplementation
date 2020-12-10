//
//  AnyService.swift
//  MVVMCombineImplementation
//
//  Created by Artem Semavin on 09.12.2020.
//

import Foundation
import TableViewExample

final class AnyService {
    static let shared = AnyService()
}

// MARK: - TableViewService

extension AnyService: TableViewService {
    func getItems(completion: (([TableViewServiceModel]) -> Void)) {
        completion([
            AnyServiceModel(id: "0", title: "Item1"),
            AnyServiceModel(id: "1", title: "Item2"),
            AnyServiceModel(id: "2", title: "Item3"),
            AnyServiceModel(id: "3", title: "Item4"),
            AnyServiceModel(id: "4", title: "Item5"),
        ])
    }
}
