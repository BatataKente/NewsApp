//
//  Network.swift
//  News
//
//  Created by Josicleison on 10/10/22.
//

import Foundation

class Network {
    
    static let shared = Network()
    
    struct Constants {
        
        static let url = URL(string: "https://newsapi.org/v2/top-headlines?country=US&apiKey=eda6154a62744b7bbad849130a7f7b6f")
    }
    
    func callArticles(escape: @escaping(Result<Articles, Error>) -> Void) {
        
        guard let url = Constants.url else {print("URL nor found."); return}
                
        URLSession.shared.dataTask(with: url) {data, result, error in
            
            if let error = error {escape(.failure(error))
                
                print("ERROR: \(error)"); return
            }
            if let result = result {print(result)}
            if let data = data {
                
                do {
                    
                    let articles = try JSONDecoder().decode(Articles.self, from: data)
                    DispatchQueue.main.async {escape(.success(articles))}
                }
                catch {
                    
                    escape(.failure(error))
                }
            }
        }.resume()
    }
    
    static func callData(_ url: URL, escape: @escaping(Data) -> Void) {
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            
            if let error = error {print("ERROR: \(error)"); return}
            if let response = response {print(response)}
            if let data = data {
                
                DispatchQueue.main.async {escape(data)}
            }
            
        }.resume()
    }
}
