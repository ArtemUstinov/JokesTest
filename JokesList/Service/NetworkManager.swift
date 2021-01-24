//
//  NetworkManager.swift
//  JokesList
//
//  Created by Артём Устинов on 24.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private enum ApiURL {
        static let countData = "https://api.icndb.com/jokes/random/%@"
    }
    
    func fetchData(countText: String, completion: @escaping([Joke]?) -> Void) {
        
        let urlString = String(format: ApiURL.countData, countText)
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                //! add .failure
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let data = try JSONDecoder().decode(SearchModel<Joke>.self, from: data)
                //! .success
                completion(data.value)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
