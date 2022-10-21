//
//  UIStackView.swift
//  News
//
//  Created by Josicleison on 21/10/22.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]) {
        
        for view in views {
            
            addArrangedSubview(view)
        }
    }
}
