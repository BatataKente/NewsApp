//
//  OtherView.swift
//  News
//
//  Created by Josicleison on 26/10/22.
//

import UIKit

class OtherView: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "\(type(of: self))"
        
        view.backgroundColor = .systemIndigo
    }
}
