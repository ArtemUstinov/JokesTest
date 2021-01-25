//
//  ErrorAlertController.swift
//  JokesList
//
//  Created by Артём Устинов on 25.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class ErrorAlertController: UIAlertController {
    
    func show(with title: Error,
              completion: @escaping (UIAlertController) -> Void) {
        let alertController = UIAlertController(
            title: "No data",
            message: title.localizedDescription,
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
            completion(alertController)
        }
    }
}
