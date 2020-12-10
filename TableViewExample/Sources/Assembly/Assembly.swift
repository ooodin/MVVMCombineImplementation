//
//  Assembly.swift
//  
//
//  Created by Artem Semavin on 08.12.2020.
//

import Foundation

public enum TableViewAssembly {
    public static func make(service: TableViewService, analytics: TableViewAnalytics) -> TableViewController {
        let viewModel = TableViewModel(service: service)

        let controller = TableViewController()
        controller.analytics = analytics
        controller.viewModel = viewModel

        return controller
    }
}
