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
        
        table.view.register(FoodViewCell.self, forCellReuseIdentifier: table.reuseIdentifier)
        
        items.bind(to: table.view.rx.items(cellIdentifier: table.reuseIdentifier,
                                           cellType: FoodViewCell.self)) {tableView, item, cell in
            
            cell.delegate = self
            cell.foodImageView.image = item.image
            cell.foodLabel.text = item.name
            
        }.disposed(by: bag)
        
        view.backgroundColor = .gray
        view.addSubview(table.view)
        
        table.view.constraint(to: view.safeAreaLayoutGuide, by: [.top,.leading,.trailing,.bottom])
    }
}

extension FoodView: FoodViewCellDelegate {
    
    func changeScreen(_ image: UIImage?, title: String?) {
        
        let foodDetailsView = FoodDetailsView(image)
        foodDetailsView.title = title
        
        navigationController?.pushViewController(foodDetailsView, animated: true)
    }
}
    
