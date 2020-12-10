//
//  UIViewController.swift
//  MVVMCombineImplementation
//
//  Created by Artem Semavin on 09.12.2020.
//

import os.log
import RouteComposer
import UIKit

extension UIViewController {
    static let router: Router = {
        let appRouterLogger: DefaultLogger
        if #available(iOS 10, *) {
            appRouterLogger = DefaultLogger(.verbose, osLog: OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "Router"))
        } else {
            appRouterLogger = DefaultLogger(.verbose)
        }
        var defaultRouter = DefaultRouter(logger: appRouterLogger)
        defaultRouter.add(NavigationDelayingInterceptor(strategy: .wait, logger: appRouterLogger))
        return defaultRouter
    }()

    var router: Router {
        UIViewController.router
    }
}
