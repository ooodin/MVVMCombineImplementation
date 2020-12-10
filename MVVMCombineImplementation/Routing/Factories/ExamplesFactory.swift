//
//  ExamplesFactory.swift
//  MVVMCombineImplementation
//
//  Created by Artem Semavin on 09.12.2020.
//

import Foundation
import RouteComposer

struct ExamplesFactory: Factory {
    typealias ViewController = ExamplesViewController
    typealias Context = Any?

    func build(with context: Context) throws -> ExamplesViewController {
        return ExamplesAssembly.make()
    }
}
