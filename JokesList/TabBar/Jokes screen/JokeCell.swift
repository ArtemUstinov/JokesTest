//
//  JokeCell.swift
//  JokesList
//
//  Created by Артём Устинов on 24.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class JokeCell: UITableViewCell {
    
    //MARK: - Override methods:
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
    }
    
    //MARK: - Public methods:
    func configure(with jokeData: Joke?) {
        textLabel?.numberOfLines = 0
        textLabel?.font = .systemFont(ofSize: 16, weight: .light)
        textLabel?.text = jokeData?.joke
    }
}
