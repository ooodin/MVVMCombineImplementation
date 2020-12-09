//
//  Assembly.swift
//  
//
//  Created by Artem Semavin on 08.12.2020.
//

import Foundation

public enum TableViewAssembly {

    //ToDo: Example for external dependency: Routing, Analytics, DataSource, etc.

    public static func make() -> TableViewController {
        let viewModel = TableViewModel()
        let controller = TableViewController()
        controller.viewModel = viewModel

        return controller
    }
}
