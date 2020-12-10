//
//  Analytics.swift
//  MVVMCombineImplementation
//
//  Created by Artem Semavin on 09.12.2020.
//

import Foundation
import TableViewExample
import os.log

final class Analytics {
    static let shred = Analytics()
}

// MARK: - TableViewAnalytics

extension Analytics: TableViewAnalytics {
    func sendEvent(name: String) {
        os_log(.default, "🐭 %@", name)
    }
}
