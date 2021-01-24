//
//  SearchModel.swift
//  JokesList
//
//  Created by Артём Устинов on 24.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

struct SearchModel<T: Decodable>: Decodable {
    let type: String?
    let value: [T]?
}
