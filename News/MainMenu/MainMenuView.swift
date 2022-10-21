//
//  MainMenuView.swift
//  News
//
//  Created by Josicleison on 21/10/22.
//

import UIKit

class MainMenuView: UIViewController {
    
    private lazy var stack: UIStackView = {
        
        let menuButton = {(viewControllet: UIViewController) -> UIButton in
            
            let handler = {(action: UIAction) in
                
                self.view.isUserInteractionEnabled = false
                self.navigationController?.pushViewController(viewControllet, animated: true)
                self.view.isUserInteractionEnabled = true
            }
            
            return Create.button("\(type(of: viewControllet))",
                                 font: Assets.font(30),
                                 image: Assets.Images.right, handler: handler)
        }
        
        let stack = UIStackView(arrangedSubviews: [menuButton(NewsView()),
                                                   menuButton(WeaterView())])
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.spacing = 5
        
        return stack
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "MainMenu"
        view.backgroundColor = .systemRed
        view.addSubview(stack)
        
        let gradient = CAGradientLayer()
        
        stack.constraint(to: view.safeAreaLayoutGuide, [.trailing: -20,.bottom: -20])
    }
}
