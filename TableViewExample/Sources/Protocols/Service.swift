//
//  Service.swift
//  
//
//  Created by Artem Semavin on 09.12.2020.
//

import Foundation

public protocol ServiceModel {
    var id: String { get }
    var title: String { get }
}

public protocol Service {
    func getItems(completion: (([ServiceModel]) -> Void))
}
