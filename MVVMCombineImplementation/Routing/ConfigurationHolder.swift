//
//  ConfigurationHolder.swift
//  MVVMCombineImplementation
//
//  Created by Artem Semavin on 09.12.2020.
//

import UIKit
import RouteComposer
import TableViewExample

protocol ExampleScreenConfiguration {
    var examplesScreen: DestinationStep<ExamplesViewController, Any?> { get }
    var customDataSourceScreen: DestinationStep<CustomDataSourceViewController, Any?> { get }
    var tableViewScreen: DestinationStep<TableViewController, Any?> { get }
}

struct ExampleConfiguration: ExampleScreenConfiguration {
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

    var tableViewScreen: DestinationStep<TableViewController, Any?> {
        StepAssembly(
            finder: ClassFinder<TableViewController, Any?>(),
            factory: TableViewFactory()
        )
        .adding(GenericContextTask<TableViewController, Any?>())
        .using(UINavigationController.push())
        .assemble(from: examplesScreen.expectingContainer())
    }
}

final class ConfigurationHolder {
    static var configuration: ExampleScreenConfiguration = ExampleConfiguration()
}

