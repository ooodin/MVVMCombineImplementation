//
//  Analytics.swift
//  
//
//  Created by Artem Semavin on 09.12.2020.
//

import Foundation

public protocol Analytics {
    func sendEvent(name: String)
}
