//
//  CustomDataSourceAssembly.swift
//  MVVMCombineImplementation
//
//  Created by Artem Semavin on 09.12.2020.
//

import Foundation

enum CustomDataSourceAssembly {
    static func make() -> CustomDataSourceViewController {
        let viewController = CustomDataSourceViewController()
        viewController.viewModel = CustomDataSourceViewModel()

        return viewController
    }
}

