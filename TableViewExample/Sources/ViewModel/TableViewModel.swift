//
//  TableViewModel.swift
//  MVPImplementation
//
//  Created by Artem Semavin on 03.12.2020.
//

import Foundation
import Combine

final class TableViewModel {
    @Published private(set) var title: String?
    @Published private(set) var items: [CellItem] = []

    func viewDidLoad() {
        title = "SPM Screen module"
        
        items = [
            CellItem(id: "0", title: "It's custom cell number 1"),
            CellItem(id: "1", title: "It's custom cell number 2"),
            CellItem(id: "2", title: "It's custom cell number 3"),
        ]
    }
}
