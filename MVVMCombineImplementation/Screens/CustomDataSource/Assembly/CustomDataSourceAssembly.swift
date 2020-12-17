//
//  CustomDataSourceAssembly.swift
//  MVVMCombineImplementation
//
//  Created by Artem Semavin on 09.12.2020.
//

import Foundation

enum CustomDataSourceAssembly {
    static func make() -> CustomDataSourceViewController {
        let viewModel = CustomDataSourceViewModel()
        return CustomDataSourceViewController(viewModel: viewModel)
    }
}

