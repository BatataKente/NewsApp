//
//  View_3.swift
//  News
//
//  Created by Josicleison on 21/10/22.
//

import UIKit
import SafariServices

class OtherNewsView: UIViewController {
    
    private var cars: RSS? = nil
    
    private let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .systemRed
        
        return tableView
    }()
    
    private let cell = {(text: String,
                         imageLink: String) -> UITableViewCell in
        
        let cell = UITableViewCell()
        
        let label = Create.label(text)
        
        Network.call(imageLink) {data in
            
            let imageView = Create.imageView(UIImage(data: data))
            
            cell.addSubview(imageView)
            imageView.constraint(by: [.top, .leading, .bottom])
            imageView.constraint(by: [.width], multiplier: 0.4)
            
        }
        
        cell.addSubview(label)
        label.constraint(by: [.top, .trailing, .bottom])
        label.constraint(by: [.width], multiplier: 0.55)
        
        return cell
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "\(type(of: self))"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        Network.call("https://g1.globo.com/rss/g1/carros") {data in
            
            let cars = Network.XML.decode(data, from: RSS.self)
            
            self.cars = cars
            self.tableView.reloadData()
        }
        
        view.addSubview(tableView)
        view.backgroundColor = .systemOrange
        
        tableView.constraint(to: view.safeAreaLayoutGuide,
                             by: [.top,.leading,.trailing,.bottom])
    }
}

extension OtherNewsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let link = cars?.channel?.link
        guard let url = URL(string: link ?? "") else {return}
        
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cars?.channel?.item.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = cars?.channel?.item else {return UITableViewCell()}
        
        return cell(item[indexPath.row].title ?? "",
                    String(item[indexPath.row].description?.split(separator: "\"")[1] ?? ""))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.frame.height/7
    }
}
