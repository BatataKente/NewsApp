//
//  FoodViewCell.swift
//  News
//
//  Created by Josicleison Elves on 16/08/1401 AP.
//

import UIKit
 
protocol FoodViewCellDelegate: AnyObject {
    
    func changeScreen(_ image: UIImage?, title: String?)
}

class FoodViewCell: UITableViewCell {
    
    weak var delegate: FoodViewCellDelegate?
    
    let foodLabel = Create.label()
    let foodImageView = Create.imageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [foodLabel, foodImageView])
        stack.backgroundColor = .lightGray
        stack.distribution = .fillEqually
        
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        self.contentView.addSubview(stack)
        self.backgroundColor = .white
        
        stack.constraint([.top: 0, .leading: 10, .trailing: -10, .bottom: 0])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        if selected {
            
            delegate?.changeScreen(foodImageView.image, title: foodLabel.text)
        }
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
