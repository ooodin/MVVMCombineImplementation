//
//  ExamplesViewModel.swift
//  MVPImplementation
//
//  Created by Artem Semavin on 03.12.2020.
//

import Foundation
import Combine

final class ExamplesViewModel {
    @Published private(set) var title: String?
    @Published private(set) var items: [ExamplesCellItem] = []

    func viewDidLoad() {
        title = "Example list"
        
        items = [
            ExamplesCellItem(id: "0", title: "SPM Screen module"),
            ExamplesCellItem(id: "1", title: "Table view screen (default data source)"),
            ExamplesCellItem(id: "2", title: "Table view screen (custom data source)"),
        ]
    }
}
