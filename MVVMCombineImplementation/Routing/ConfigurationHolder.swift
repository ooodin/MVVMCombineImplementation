//
//  ConfigurationHolder.swift
//  MVVMCombineImplementation
//
//  Created by Artem Semavin on 09.12.2020.
//

import UIKit
import RouteComposer
import TableViewExample

protocol GeneralFlows {
    var examplesScreen: DestinationStep<ExamplesViewController, Any?> { get }
    var customDataSourceScreen: DestinationStep<CustomDataSourceViewController, Any?> { get }
    var tableViewScreen: DestinationStep<TableViewExample.ViewController, Any?> { get }
}

struct GeneralFlowsPhone: GeneralFlows {
    private var rootNavigationController: DestinationStep<UINavigationController, Any?> {
        StepAssembly(
            finder: NilFinder(),
            factory: NavigationControllerFactory<UINavigationController, Any?>()
        )
        .adding(GenericContextTask<UINavigationController, Any?>())
        .using(GeneralAction.replaceRoot())
        .assemble(from: GeneralStep.current())
    }

    var examplesScreen: DestinationStep<ExamplesViewController, Any?> {
        StepAssembly(
            finder: ClassFinder<ExamplesViewController, Any?>(),
            factory: ExamplesFactory()
        )
        .adding(GenericContextTask<ExamplesViewController, Any?>())
        .using(UINavigationController.pushAsRoot())
        .assemble(from: rootNavigationController.expectingContainer())
    }

    var customDataSourceScreen: DestinationStep<CustomDataSourceViewController, Any?> {
        StepAssembly(
            finder: ClassFinder<CustomDataSourceViewController, Any?>(),
            factory: CustomDataSourceFactory()
        )
        .adding(GenericContextTask<CustomDataSourceViewController, Any?>())
        .using(UINavigationController.push())
        .assemble(from: examplesScreen.expectingContainer())
    }

    var tableViewScreen: DestinationStep<TableViewExample.ViewController, Any?> {
        StepAssembly(
            finder: ClassFinder<TableViewExample.ViewController, Any?>(),
            factory: TableViewFactory()
        )
        .adding(GenericContextTask<TableViewExample.ViewController, Any?>())
        .using(UINavigationController.push())
        .assemble(from: examplesScreen.expectingContainer())
    }
}

final class App {
    static var flows: GeneralFlows = GeneralFlowsPhone()
}
