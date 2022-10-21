//
//  Create.swift
//  News
//
//  Created by Josicleison on 10/10/22.
//

import UIKit

struct Assets {
    
    static let font = {(size: CGFloat) -> UIFont in
        
        UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    struct Images {
        
        static let right = UIImage(systemName: "chevron.right")
        static let left = UIImage(systemName: "chevron.left")
    }
}
