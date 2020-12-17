//
//  AnyServiceModel.swift
//  MVVMCombineImplementation
//
//  Created by Artem Semavin on 09.12.2020.
//

import Foundation
import TableViewExample

struct AnyServiceModel {
    let id: String
    let title: String
}

// MARK: - TableViewServiceModel

extension AnyServiceModel: TableViewExample.ServiceModel {}
