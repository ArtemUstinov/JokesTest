//
//  NetworkManager.swift
//  JokesList
//
//  Created by Артём Устинов on 24.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import Foundation

enum ApiURL {
    static let countData = "https://api.icndb.com/jokes/random/%@"
    static let website = "http://www.icndb.com/api/"
}

class NetworkManager {
    
    func fetchData(countText: String,
                   completion: @escaping(Result<[Joke]?, Error>) -> Void) {
        
        let urlString = String(format: ApiURL.countData, countText)
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let data = try JSONDecoder().decode(SearchModel<Joke>.self,
                                                    from: data)
                DispatchQueue.main.async {
                    completion(.success(data.value))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                print(error.localizedDescription)
            }
        }.resume()
    }
}
