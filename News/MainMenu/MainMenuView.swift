//
//  MainMenuView.swift
//  News
//
//  Created by Josicleison on 21/10/22.
//

import UIKit

class MainMenuView: UIViewController {
    
    lazy var button = {(viewController: UIViewController) -> UIButton in
        
        let handler = {(action: UIAction) in
            
            self.view.isUserInteractionEnabled = false
            self.navigationController?.pushViewController(viewController, animated: true)
            self.view.isUserInteractionEnabled = true
        }
        
        return Create.button("\(type(of: viewController))",
                             font: Assets.font(self.view.frame.width/13),
                             image: Assets.Images.right, handler: handler)
    }
    
    let stack: UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.spacing = 5
        
        return stack
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "MainMenu"
        
        let view_2 = FoodView()
        view_2.view.backgroundColor = .systemBrown
        view_2.title = "\(type(of: view_2))"
        
        stack.addArrangedSubviews([button(NewsView()),
                                   button(WheaterView()),
                                   button(HelloView()),
                                   button(RingView()),
                                   button(OtherView()),
                                   button(WrongWayDecodeView()),
                                   button(RXSwiftMenuView()),
                                   button(OtherNewsView()),
                                   button(BatmanView()),
                                   button(PageView())])
        
        view.backgroundColor = .systemRed
        view.addSubview(stack)
        
        stack.constraint(to: view.safeAreaLayoutGuide, [.trailing: -20,.bottom: -20])
    }
}
