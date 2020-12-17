//
//  GenericContextTask.swift
//  MVVMCombineImplementation
//
//  Created by Artem Semavin on 09.12.2020.
//

import RouteComposer
import UIKit

struct GenericContextTask<VC: UIViewController, C>: ContextTask {
    func perform(on viewController: VC, with context: C) throws {
        print("View controller name is \(String(describing: viewController))")
    }
}

