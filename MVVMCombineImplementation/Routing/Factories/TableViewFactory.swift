//
//  TableViewFactory.swift
//  MVVMCombineImplementation
//
//  Created by Artem Semavin on 09.12.2020.
//

import Foundation
import RouteComposer
import TableViewExample

struct TableViewFactory: Factory {
    typealias ViewController = TableViewExample.ViewController
    typealias Context = Any?

    func build(with context: Any?) throws -> TableViewExample.ViewController {
        return TableViewExample.Assembly.make(service: AnyService.shared, analytics: Analytics.shred)
    }
}
