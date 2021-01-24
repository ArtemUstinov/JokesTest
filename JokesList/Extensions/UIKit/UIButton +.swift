//
//  UIButton +.swift
//  JokesList
//
//  Created by Артём Устинов on 24.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init (
        text: String,
        cornerRadius: CGFloat
    ) {
        self.init(type: .system)
        backgroundColor = .black
        setTitle(text, for: .normal)
        tintColor = .white
        layer.cornerRadius = cornerRadius
    }
}
