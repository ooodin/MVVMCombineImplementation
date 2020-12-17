//
//  File.swift
//  
//
//  Created by Artem Semavin on 09.12.2020.
//

import UIKit

public extension UITableView {
    func register<T>(_ type: T.Type) where T: UITableViewCell {
        let identifier = String(describing: T.self)
        self.register(T.self, forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T where T: UITableViewCell {
        let identifier = String(describing: T.self)
        let defaultCell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        guard let cell = defaultCell as? T else {
            fatalError()
        }
        return cell
    }
}
