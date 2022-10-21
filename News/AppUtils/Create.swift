//
//  Create.swift
//  News
//
//  Created by Josicleison on 10/10/22.
//

import UIKit

struct Create {
    
    static func imageView(_ image: UIImage? = nil,
                          color: UIColor? = nil) -> UIImageView {
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.tintColor = color
        imageView.layer.masksToBounds = true
        
        return imageView
    }
    
    static func label(_ text: String? = nil,
                      font: UIFont? = Assets.font(25),
                      alignment: NSTextAlignment = .left) -> UILabel {
        
        let label = UILabel()
        label.text = text
        label.font = font
        label.textAlignment = alignment
        label.numberOfLines = 0
        
        return label
    }
    
    static func button(_ title: String? = nil,
                       font: UIFont? = Assets.font(25),
                       image: UIImage? = nil,
                       handler: @escaping UIActionHandler) -> UIButton {
        
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(Assets.Colors.reverseDark, for: .normal)
        button.setImage(image, for: .normal)
        button.tintColor = Assets.Colors.reverseDark
        button.addAction(UIAction(handler: handler), for: .touchUpInside)
        button.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        button.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.titleLabel?.font = font
        
        button.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.imageView?.constraint(to: button.titleLabel, by: [.height],
                                     multiplier: 0.9)
        button.imageView?.constraint(to: button.imageView, with: [.width: .height],
                                     multiplier: 0.7)
        
        return button
    }
}
