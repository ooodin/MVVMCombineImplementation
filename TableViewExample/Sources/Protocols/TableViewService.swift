//
//  TableViewService.swift
//  
//
//  Created by Artem Semavin on 09.12.2020.
//

import Foundation

public protocol TableViewServiceModel {
    var id: String { get }
    var title: String { get }
}

public protocol TableViewService {
    func getItems(completion: (([TableViewServiceModel]) -> Void))
}
