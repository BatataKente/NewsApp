//
//  UIView.swift
//  News
//
//  Created by Josicleison on 10/10/22.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        
        for view in views {
            
            addSubview(view)
        }
    }
    
    func shape(height: CGFloat? = nil, width: CGFloat? = nil, size: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let height = height {heightAnchor.constraint(equalToConstant: height).isActive = true}
        else if let width = width {widthAnchor.constraint(equalToConstant: width).isActive = true}
        else if let size = size {
            
            heightAnchor.constraint(equalToConstant: size).isActive = true
            widthAnchor.constraint(equalToConstant: size).isActive = true
        }
    }
    
    func constraint(to item: Any? = nil,
                    relation: NSLayoutConstraint.Relation = .equal,
                    by attributes: [NSLayoutConstraint.Attribute]? = nil,
                    with attributes_attributes: [NSLayoutConstraint.Attribute:
                                                 NSLayoutConstraint.Attribute]? = nil,
                    _ attributes_constants: [NSLayoutConstraint.Attribute:
                                             CGFloat]? = nil,
                    multiplier: CGFloat = 1,
                    constant: CGFloat? = nil) {

        translatesAutoresizingMaskIntoConstraints = false

        guard let superview = self.superview else {return}
        if let attributes = attributes {

            for attribute in attributes {

                superview.addConstraint(NSLayoutConstraint(item: self,
                                                           attribute: attribute,
                                                           relatedBy: relation,
                                                           toItem: item ?? superview,
                                                           attribute: attribute,
                                                           multiplier: multiplier,
                                                           constant: constant ?? 0))
            }
        }
        if let attributes = attributes_attributes {

            for attribute in attributes {

                superview.addConstraint(NSLayoutConstraint(item: self,
                                                           attribute: attribute.key,
                                                           relatedBy: relation,
                                                           toItem: item ?? superview,
                                                           attribute: attribute.value,
                                                           multiplier: multiplier,
                                                           constant: constant ?? 0))
            }
        }
        if let attributes = attributes_constants {

            for attribute in attributes {

                superview.addConstraint(NSLayoutConstraint(item: self,
                                                           attribute: attribute.key,
                                                           relatedBy: relation,
                                                           toItem: item ?? superview,
                                                           attribute: attribute.key,
                                                           multiplier: multiplier,
                                                           constant: attribute.value))
            }
        }
    }
}
