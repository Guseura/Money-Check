//
//  DefaultCategories.swift
//  moneycheck
//
//  Created by Yurij Goose on 18.01.21.
//

import Foundation

func getDefaultCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
    
    let urlString = "https://moneycheck.site/api.php"
    
    guard let url = URL(string: urlString) else {
        fatalError()
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        
        guard let data = data, error == nil else {
            completion(.failure(error!))
            return
        }
        
        do {
            
            let categories = try JSONDecoder().decode([Category].self, from: data)
            completion(.success(categories))
            
        } catch {
            completion(.failure(error))
        }
        
    }.resume()
    
}


