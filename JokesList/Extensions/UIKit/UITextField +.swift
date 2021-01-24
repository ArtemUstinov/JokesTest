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
        placeholder: String
    ) {
        self.init()
        backgroundColor = .secondarySystemBackground
        self.placeholder = placeholder
        textAlignment = .center
    }
}
