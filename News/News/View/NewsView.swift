//
//  ViewController.swift
//  News
//
//  Created by Josicleison on 10/10/22.
//

import UIKit
import SafariServices

class NewsView: UIViewController {
    
    private var viewModels:[NewsCellViewModel] = []
    private var articles = [Article]()

    private let table: UITableView = {
        
        let table = UITableView()
        table.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        
        return table
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "News"
        view.addSubview(table)
        
        table.delegate = self
        table.dataSource = self
        
        table.constraint(by: [.top,.leading,.trailing,.bottom])
        
        Network.call(Network.Constants.url, isRequiredKey: true) {[weak self] data in
            
            guard let articles = Network.decode(data, from: Articles.self)?.articles else {return}
            
            self?.articles = articles
            self?.viewModels = articles.compactMap{

                NewsCellViewModel(title: $0.title ?? "No Title",
                                  subTitle: $0.articleDescription ?? "No Description",
                                  imageURL: $0.urlToImage)
            }
            self?.table.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        table.frame = view.bounds
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
        
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier,
                                                       for: indexPath) as? NewsCell
        else {
            
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        150
    }
}
