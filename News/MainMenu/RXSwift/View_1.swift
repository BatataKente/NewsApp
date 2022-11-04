//
//  View_1.swift
//  News
//
//  Created by Josicleison Elves on 09/08/1401 AP.
//

import UIKit
import RxSwift
import RxCocoa

class View_1: UIViewController {
    
    fileprivate let bag = DisposeBag()
    
    fileprivate let allSymbols = ["RZW","UDP","MTT","ZKQ","IPK","Ænima"]
    fileprivate let allCars = BehaviorRelay<RSS>(value: RSS(channel: nil, version: nil))
    
    fileprivate let cars = BehaviorRelay<RSS>(value: RSS(channel: nil, version: nil))
    
    private let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Lero Lero")
        tableView.backgroundColor = .systemRed
        
        return tableView
    }()
    
    private struct CustomView {
        
        let stack: UIStackView, favoritesSwitch: UISwitch, searchTextField: UITextField
    }
    
    private let customView: CustomView = {
        
        let favoritesSwitch = UISwitch()
        
        let favoritesStack = UIStackView(arrangedSubviews: [Create.label("Show only favorites"), favoritesSwitch])
        favoritesStack.distribution = .fillEqually
        
        let searchTextField = Create.textField(background: .white)
        
        let searchStack = UIStackView(arrangedSubviews: [Create.label("Search"),
                                                         searchTextField])
        searchStack.distribution = .fillEqually
        
        let stack = UIStackView(arrangedSubviews: [favoritesStack, searchStack])
        stack.axis = .vertical
        stack.backgroundColor = .opaqueSeparator
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 20,
                                           bottom: 20, right: 20)
        
        return CustomView(stack: stack,
                          favoritesSwitch: favoritesSwitch,
                          searchTextField: searchTextField)
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
            
            guard let cars = Network.XML.decode(RSS.self, from: data) else {return}
            
            self.allCars.accept(cars)
            self.tableView.reloadData()
        }
        
        view.addSubviews([customView.stack, tableView])
        view.backgroundColor = .systemYellow
        
        customView.stack.constraint(to: view.safeAreaLayoutGuide, by: [.top,.leading,.trailing])
        
        tableView.constraint(to: customView.stack, with: [.top:.bottom])
        tableView.constraint(to: view.safeAreaLayoutGuide, by: [.leading,.trailing,.bottom])
        
        bind()
    }
}

extension View_1 {
    
    func bind() {
        
        Observable.combineLatest(allCars.asObservable(),
                                 customView.favoritesSwitch.rx.isOn,
                                 customView.searchTextField.rx.text) {car, favorites, search in
            
            print(favorites, search as Any)
            
        }.subscribe()
         .dispose()
    }
}

extension View_1: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allCars.value.channel?.item.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = allCars.value.channel?.item else {return UITableViewCell()}
        
        return cell(item[indexPath.row].title ?? "",
                    String(item[indexPath.row].description?.split(separator: "\"")[1] ?? ""))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.frame.height/7
    }
}
