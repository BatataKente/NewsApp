//
//  View.swift
//  News
//
//  Created by Josicleison on 25/10/22.
//

import UIKit
import RxSwift

class HelloView: UIViewController {
    
    private let label = Create.label("Hello Crazy World")
    
    private let stack: UIStackView = Create.stack()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "\(type(of: self))"
        
        stack.addArrangedSubviews([label,
                                   button()])
        
        view.backgroundColor = .systemTeal
        view.addSubview(stack)
        
        stack.constraint(by: [.centerX,.centerY])
    }
    
    private func button() -> UIButton {
        
        return Create.button("Toca aqui") {_ in
            
            let animalsView = AnimalsView()
            animalsView.delegate = self
            
            self.navigationController?.pushViewController(animalsView,
                                                          animated: true)
        }
    }
}

extension HelloView: AnimalsViewDelegate {
    
    func setupLabel(_ text: String) {
        
        label.text = text
    }
}
