//
//  View_3.swift
//  News
//
//  Created by Josicleison on 21/10/22.
//

import UIKit
import SafariServices

class OtherNewsView: UIViewController {
    
    private let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.register(NewsViewCell.self,
                           forCellReuseIdentifier: NewsViewCell.identifier)
        tableView.backgroundColor = .systemRed
        
        return tableView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "\(type(of: self))"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        Network.call("https://g1.globo.com/rss/g1/carros") {data in
            
            let cars = Network.XML.decode(data, from: Note.self)
            
            print(cars as Any)
        }
        
        
        view.addSubview(tableView)
        view.backgroundColor = .systemOrange
        
        tableView.constraint(to: view.safeAreaLayoutGuide,
                             by: [.top,.leading,.trailing,.bottom])
    }
}

extension OtherNewsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsViewCell.identifier,
                                                 for: indexPath) as? NewsViewCell
        
        return cell ?? UITableViewCell()
    }
}
