//
//  ExampleListViewModel.swift
//  MVPImplementation
//
//  Created by Artem Semavin on 03.12.2020.
//

import Foundation
import Combine

final class ExampleListViewModel {
    @Published private(set) var title: String?
    @Published private(set) var items: [ExampleListTableViewItem] = []

    func viewDidLoad() {
        title = "Example list"
        
        items = [
            ExampleListTableViewItem(id: "0", title: "Simple view screen"),
            ExampleListTableViewItem(id: "1", title: "Table view screen (default data source)"),
            ExampleListTableViewItem(id: "2", title: "Table view screen (custom data source)"),
        ]
    }
}
