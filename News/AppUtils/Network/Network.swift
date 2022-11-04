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
    
    enum EndPoints {
        
        static let url = "https://newsapi.org/v2/top-headlines?country=US&apiKey="
        static let omdbapi = "https://www.omdbapi.com/?s=Batman&page=2&apikey="
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
        
        static func decode<T: Codable>(_ model: T.Type, from data: Data) -> T? {
            
            do {
                
                let articles = try XMLDecoder().decode(T.self, from: data)
                return articles
            }
            catch {
                
                print("ERROR: \(error)"); return nil
            }
        }
    }
    
    struct Async {
        
        static func call(from url: String?, withKey: Bool = true) async -> Data? {

            guard var url = url else {print("ERROR: Wrong url"); return nil}
            if withKey {url += "f1a110d5"}
            guard let url = URL(string: url) else {print("ERROR: Wrong url"); return nil}

            do {

                let (data, response) = try await URLSession.shared.data(from: url)
                print("RESPONSE:", response)

                return data
            }
            catch {print("ERROR: \(error)"); return nil}
        }

        static func decode<T: Codable>(_ what: T.Type, from data: Data) -> T? {

            do {

                return try JSONDecoder().decode(what.self, from: data)
            }
            catch {print("ERROR: \(error)"); return nil}
        }
    }
}
