//
//  View_2.swift
//  News
//
//  Created by Josicleison Elves on 10/08/1401 AP.
//

import UIKit
import RxSwift
import RxCocoa

class FoodView: UIViewController {
    
    private let items = Observable.just([Food(name: "pizza", image: Assets.Images.pizza),
                                         Food(name: "hamburguer", image: Assets.Images.hamburguer),
                                         Food(name: "salmon", image: Assets.Images.salmon)])
    private let bag = DisposeBag()
    
    private let table: (view: UITableView, reuseIdentifier: String) = {
        
        let tableView = UITableView()
        tableView.bounces = false
        tableView.rowHeight = 150
        
        return (view: tableView, reuseIdentifier: "Cell")
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "\(type(of: self))"
        
        table.view.register(UITableViewCell.self, forCellReuseIdentifier: table.reuseIdentifier)
        
        items.bind(to: table.view.rx.items(cellIdentifier: table.reuseIdentifier,
                                           cellType: UITableViewCell.self)) {tableView, item, cell in
            
            let stack = UIStackView(arrangedSubviews: [Create.label(item.name), Create.imageView(item.image)])
            stack.backgroundColor = .lightGray
            stack.distribution = .fillEqually
            
            stack.isLayoutMarginsRelativeArrangement = true
            stack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            
            cell.contentView.addSubview(stack)
            cell.backgroundColor = .white
            
            stack.constraint([.top: 0, .leading: 10, .trailing: -10, .bottom: 0])
            
        }.disposed(by: bag)
        
        table.view.rx.modelSelected(Food.self).subscribe {food in
            
            self.navigationController?.pushViewController(FoodDetailsView(food.image), animated: true)
        }.disposed(by: bag)
        
        view.backgroundColor = .gray
        view.addSubview(table.view)
        
        table.view.constraint(to: view.safeAreaLayoutGuide, by: [.top,.leading,.trailing,.bottom])
    }
}
