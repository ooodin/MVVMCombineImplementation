//
//  Assembly.swift
//  
//
//  Created by Artem Semavin on 08.12.2020.
//

import Foundation

public enum Assembly {
    public static func make(service: Service, analytics: Analytics) -> ViewController {
        let viewModel = ViewModel(service: service)
        return ViewController(analytics: analytics, viewModel: viewModel)
    }
}
