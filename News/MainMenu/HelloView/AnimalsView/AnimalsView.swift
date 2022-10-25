//
//  AnimalsView.swift
//  News
//
//  Created by Josicleison on 25/10/22.
//

import UIKit
import RxSwift
import RxRelay

class AnimalsView: UIViewController {
    
    private let stack: UIStackView = Create.stack()
    
    private let selected = BehaviorRelay(value: "Crazy World")
    
    var animal: Observable<String> {
        
        return selected.asObservable()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "\(type(of: self))"
        
        stack.addArrangedSubviews([button("Galinha"),
                                   button("Vaca"),
                                   button("Cabra"),
                                   button("Boi"),
                                   button("Porco")])
        
        view.backgroundColor = .systemGreen
        view.addSubview(stack)
        
        stack.constraint(by: [.centerX,.centerY])
    }
    
    private func button(_ title: String) -> UIButton {
        
        return Create.button(title) {_ in
            
            self.selected.accept("Hello \(title)")
            self.navigationController?.popViewController(animated: true)
        }
    }
}

