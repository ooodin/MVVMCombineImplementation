//
//  ExamplesAssembly.swift
//  MVVMCombineImplementation
//
//  Created by Artem Semavin on 08.12.2020.
//

import Foundation

enum ExamplesAssembly {
    static func make() -> ExamplesViewController {
        let viewController = ExamplesViewController()
        viewController.viewModel = ExamplesViewModel()

        return viewController
    }
}
