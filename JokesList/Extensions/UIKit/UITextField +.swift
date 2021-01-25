//
//  UITextField +.swift
//  JokesList
//
//  Created by Артём Устинов on 24.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

extension UITextField {
    
    convenience init (
        placeholder: String? = nil,
        cornerRadius: CGFloat
    ) {
        self.init()
        if #available(iOS 13.0, *) {
            backgroundColor = .secondarySystemBackground
        } else {
            backgroundColor = .lightText
        }
        self.placeholder = placeholder
        textAlignment = .center
        keyboardType = .numberPad
        layer.cornerRadius = cornerRadius
    }
}
