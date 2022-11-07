//
//  RXSwiftMenu.swift
//  News
//
//  Created by Josicleison Elves on 16/08/1401 AP.
//

import UIKit

class RXSwiftMenuView: MainMenuView {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "MainMenu(RXSwift)"
        
        view.backgroundColor = UIColor.systemIndigo
        
        stack.removeArrangedSubviews()
        
        stack.addArrangedSubviews([button(View_0()),
                                   button(View_1()),
                                   button(FoodView())])
    }
}
