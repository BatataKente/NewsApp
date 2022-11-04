//
//  View_3.swift
//  News
//
//  Created by Josicleison on 21/10/22.
//

import UIKit
import SafariServices

class NewsView: UIViewController {
    
    private var articles: [Article] = []
    
    private let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.register(NewsViewCell.self,
                           forCellReuseIdentifier: NewsViewCell.identifier)
        tableView.backgroundColor = .systemRed
        
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
        
        Network.call(Network.EndPoints.url, isRequiredKey: true) {[weak self] data in

            guard let articles = Network.decode(data, from: Articles.self)?.articles else {return}

            self?.articles = articles
            self?.tableView.reloadData()
        }
    }
}

extension NewsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let article = articles[indexPath.row]
        guard let url = URL(string: article.url ?? "") else {return}
        
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsViewCell.identifier,
                                                 for: indexPath) as? NewsViewCell
        cell?.setup(articles[indexPath.row].title ?? "",
                    imageLink: articles[indexPath.row].urlToImage ?? "")
        
        return cell ?? UITableViewCell()
    }
}
