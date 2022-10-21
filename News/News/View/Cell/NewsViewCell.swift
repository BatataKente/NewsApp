//
//  View_3Cell.swift
//  News
//
//  Created by Josicleison on 21/10/22.
//

import UIKit

class NewsViewCell: UITableViewCell {
    
    static let identifier = "Cell"
    
    private let label: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Assets.font(17.5)
        
        return label
    }()
    
    private let articleImage = Create.imageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews([label, articleImage])
        
        label.constraint(by: [.top,.leading,.bottom])
        label.constraint(by: [.width], multiplier: 0.6)
        label.shape(height: 120)
        
        articleImage.constraint(by: [.top,.trailing,.bottom])
        articleImage.constraint(by: [.width], multiplier: 0.4)
    }
    
    func setup(_ article: String, imageLink: String) {
        
        label.text = article
        
        Network.call(imageLink) {[weak self] data in
            
            self?.articleImage.image = UIImage(data: data)
        }
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
