//
//  MainMenuView.swift
//  News
//
//  Created by Josicleison on 21/10/22.
//

import UIKit

class MainMenuView: UIViewController {
    
    private lazy var button = {(viewControllet: UIViewController) -> UIButton in
        
        let handler = {(action: UIAction) in
            
            self.view.isUserInteractionEnabled = false
            self.navigationController?.pushViewController(viewControllet, animated: true)
            self.view.isUserInteractionEnabled = true
        }
        
        return Create.button("\(type(of: viewControllet))",
                             font: Assets.font(30),
                             image: Assets.Images.right, handler: handler)
    }
    
    private let stack: UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.spacing = 5
        
        return stack
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "MainMenu"
        
        let view_2 = View_2()
        view_2.view.backgroundColor = .systemBrown
        view_2.title = "\(type(of: view_2))"
        
        stack.addArrangedSubviews([button(NewsView()), button(WheaterView()), button(HelloView()), button(RingView()), button(OtherView()), button(View_0()), button(View_1()), button(view_2), button(OtherNewsView())])
        
        view.backgroundColor = .systemRed
        view.addSubview(stack)
        
        stack.constraint(to: view.safeAreaLayoutGuide, [.trailing: -20,.bottom: -20])
    }
}
