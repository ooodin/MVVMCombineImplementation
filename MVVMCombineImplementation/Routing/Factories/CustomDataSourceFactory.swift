//
//  CustomDataSourceFactory.swift
//  MVVMCombineImplementation
//
//  Created by Artem Semavin on 09.12.2020.
//

import Foundation
import RouteComposer

struct CustomDataSourceFactory: Factory {
    typealias ViewController = CustomDataSourceViewController
    typealias Context = Any?

    func build(with context: Context) throws -> CustomDataSourceViewController {
        return CustomDataSourceAssembly.make()
    }
}
