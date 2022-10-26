//
//  Network.swift
//  News
//
//  Created by Josicleison on 10/10/22.
//

import Foundation
import XMLCoder

class Network {
    
    static let shared = Network()
    
    enum Constants {
        
        static let url = "https://newsapi.org/v2/top-headlines?country=US&apiKey="
    }
    
    private enum Keys {
        
        static let me = "eda6154a62744b7bbad849130a7f7b6f"
    }
    
    static func call(_ url: String, isRequiredKey: Bool = false, escape: @escaping(Data) -> Void) {
        
        var url = url
        if isRequiredKey {url += Keys.me}
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url) {data, response, error in
            
            if let error = error {print("ERROR: \(error)"); return}
            if let response = response {print(response)}
            if let data = data {
                
                DispatchQueue.main.async {escape(data)}
            }
            
        }.resume()
    }
    
    static func decode<T: Codable>(_ data: Data, from type: T.Type) -> T? {
        
        do {
            
            let articles = try JSONDecoder().decode(T.self, from: data)
            return articles
        }
        catch {
            
            print("ERROR: \(error)"); return nil
        }
    }
    
    struct XML {
        
        static func decode<T: Codable>(_ data: Data, from type: T.Type) -> T? {
            
            do {
                
                let articles = try XMLDecoder().decode(T.self, from: data)
                return articles
            }
            catch {
                
                print("ERROR: \(error)"); return nil
            }
        }
    }
}
