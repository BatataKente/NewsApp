//
//  OtherView.swift
//  News
//
//  Created by Josicleison on 26/10/22.
//

import UIKit

class OtherView: UIViewController {
    
    private var names = [["Porco", "Galinha", "Cabra"],
                         ["Macaco", "Vaca", "Boi", "Galo"],
                         ["Escorpiao", "Gato", "Touro"],
                         ["Chinelo", "Goiaba", "Taioba"],
                         ["Jaca", "Vinagre", "Farofa"]]
    
    private static let identifier = "Cell"
    private let cell = {(names: [String]) -> UITableViewCell in
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        cell.backgroundColor = .systemOrange
        
        var labels = [UILabel]()
        
        for name in names {
            
            labels.append(Create.label(name, alignment: .center))
        }
        
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.backgroundColor = .systemPink
        stackView.distribution = .fillEqually
        
        cell.contentView.addSubview(stackView)
        
        stackView.constraint([.top:20,.leading:0,.trailing:0,.bottom:-20])
        
        return cell
    }
    
    private let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.backgroundColor = .systemPurple
        
        return tableView
    }()
    
    private let textField = Create.textField()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "\(type(of: self))"
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: OtherView.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        let button = button()
        
        view.backgroundColor = .systemIndigo
        view.addSubviews([tableView, button, textField])
        
        tableView.constraint(to: view.safeAreaLayoutGuide,
                             by: [.top,.leading,.trailing])
        
        textField.constraint(to: tableView, with: [.top:.bottom])
        textField.constraint([.leading: 10,.trailing: -10])
        
        button.constraint(to: textField, with: [.top:.bottom])
        button.constraint(to: view.safeAreaLayoutGuide, by: [.leading,.trailing,.bottom])
    }
    
    private func button(_ title: String = "Adicionar") -> UIButton {
        
        return Create.button(title) {_ in
            
            guard let text = self.textField.text else {return}
            let texts = text.split(separator: " ") as? [String]
            
            self.names.append(texts ?? [text])
            self.tableView.reloadData()
        }
    }
}

extension OtherView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return cell(names[indexPath.row])
    }
}
