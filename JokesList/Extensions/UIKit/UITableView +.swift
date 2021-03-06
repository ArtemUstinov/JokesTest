//
//  UITableView +.swift
//  JokesList
//
//  Created by Артём Устинов on 24.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

extension UITableView {
    
    //MARK: - Public methods:
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(
            withIdentifier: T.identifier,
            for: indexPath
            ) as? T else {
                fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }
    
    func register(_ cellType: UITableViewCell.Type) {
        register(cellType.self,
                 forCellReuseIdentifier: cellType.identifier)
    }
}
