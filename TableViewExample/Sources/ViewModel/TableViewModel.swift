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

    private let service: TableViewService

    init(service: TableViewService) {
        self.service = service
    }

    func viewDidLoad() {
        title = "SPM Screen module"

        service.getItems { [weak self] models in
            self?.update(models: models)
        }
    }

    private func update(models: [TableViewServiceModel]) {
        items = models.compactMap {
            CellItem(id: $0.id, title: $0.title)
        }
    }
}
