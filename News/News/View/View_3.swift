//
//  View_3.swift
//  News
//
//  Created by Josicleison on 21/10/22.
//

import UIKit

class View_3: UIViewController {
    
    private var articles: [Article] = []
    
    private let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.register(View_3Cell.self,
                           forCellReuseIdentifier: View_3Cell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "News"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.backgroundColor = .systemRed
        
        tableView.constraint(to: view.safeAreaLayoutGuide,
                             by: [.top,.leading,.trailing,.bottom])
        
        Network.call(Network.Constants.url, isRequiredKey: true) {[weak self] data in

            guard let articles = Network.decode(data, from: Articles.self)?.articles else {return}

            self?.articles = articles
            self?.tableView.reloadData()
        }
    }
}

extension View_3: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: View_3Cell.identifier,
                                                 for: indexPath) as? View_3Cell
        cell?.setup(articles[indexPath.row].title ?? "",
                    imageLink: articles[indexPath.row].urlToImage ?? "")
        
        return cell ?? UITableViewCell()
    }
}
