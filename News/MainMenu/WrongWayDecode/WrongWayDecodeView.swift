//
//  WhrongWayDecode.swift
//  News
//
//  Created by Josicleison Elves on 16/08/1401 AP.
//

import UIKit

class WrongWayDecodeView: UIViewController {
    
    private let label = Create.label("aaaaaaaaa", font: Assets.font(20))
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Decode things :)"
        
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds
        gradient.colors = [UIColor.systemGreen.cgColor, UIColor.systemGreen.cgColor, UIColor.white.cgColor]

        view.layer.insertSublayer(gradient, at: 0)
        
        view.addSubview(label)
        
        label.constraint(to: view.safeAreaLayoutGuide, by: [.top,.leading,.trailing])
        
        Network.call("https://newsapi.org/v2/top-headlines?country=US&apiKey=eda6154a62744b7bbad849130a7f7b6f") {data in
            
            print(String(data: data, encoding: .ascii)?.split(separator: "\"") as Any)
            
            
        }
    }
}
