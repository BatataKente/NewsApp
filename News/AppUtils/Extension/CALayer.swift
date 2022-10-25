//
//  CALayer.swift
//  News
//
//  Created by Josicleison on 25/10/22.
//

import UIKit

extension CALayer {
    
    func addSublayers(_ layers: [CALayer]) {
        
        for layer in layers {
            
            addSublayer(layer)
        }
    }
}
