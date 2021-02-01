//
//  KeyboardProtocol.swift
//  JokesList
//
//  Created by Артём Устинов on 25.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

protocol KeyboardProtocol: AnyObject {
    var view: UIView! { get }
    func setupKeyboardHandler()
}

extension KeyboardProtocol {
    public func setupKeyboardHandler() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillChangeFrameNotification,
            object: nil,
            queue: nil) { notification in
            self.keyboardDidShow(notification)
        }
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil) { notification in
            self.keyboardWillHide(notification)
        }
    }
    
    private func keyboardDidShow(_ notification: Notification) {
        guard let keyboardSize =
                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                as? NSValue else {
            return
        }
        self.view.frame.origin.y = 0 - keyboardSize.cgRectValue.height
    }
    
    private func keyboardWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
}
