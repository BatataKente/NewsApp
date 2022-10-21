//
//  WheaterView.swift
//  News
//
//  Created by Josicleison on 21/10/22.
//

import UIKit

class WheaterView: UIViewController {
    
    private let label = Create.label("Afeganistao, Rio de janeiro",
                                     font: Assets.font(30))
    
    private let topStack: UIStackView = {
        
        let imageView = Create.imageView(Assets.Images.cloudSun,
                                         color: Assets.Colors.reverseDark)
        let label = Create.label("70°",
                                 font: Assets.font(60),
                                 alignment: .center)
        
        let topStack = UIStackView(arrangedSubviews: [imageView, label])
        topStack.axis = .vertical
        
        imageView.shape(height: 120)
        
        return topStack
    }()
    
    private let daysStack: UIStackView = {
        
        let createStack = {(wheater: UIImage?,
                            temperature: Int) -> UIStackView in
            
            let imageViews = [Create.imageView(wheater,
                                               color: Assets.Colors.reverseDark)]
            let labels = [Create.label("\(temperature)°",
                                      font: Assets.font(40),
                                      alignment: .center)]
            
            let stack = UIStackView(arrangedSubviews: imageViews + labels)
            stack.axis = .vertical
            
            return stack
        }
        
        let daysStack = UIStackView(arrangedSubviews: [createStack(Assets.Images.cloudSun, 70),
                                                       createStack(Assets.Images.cloud, 23),
                                                       createStack(Assets.Images.cloudDrizzle, 65),
                                                       createStack(Assets.Images.cloudSunBolt, 50),
                                                       createStack(Assets.Images.sunMax, 32)])
        daysStack.distribution = .fillEqually
        
        return daysStack
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Wheater"
        
        view.addSubviews([label, topStack, daysStack])
        view.backgroundColor = .systemRed
        
        label.constraint(to: view.safeAreaLayoutGuide, [.centerX: 0,.top: 50])
        label.constraint(by: [.width], multiplier: 0.7)
        
        topStack.constraint(to: label, by: [.leading,.trailing])
        topStack.constraint(to: label, with: [.top:.bottom], constant: 35)
        
        daysStack.constraint(by: [.leading,.trailing])
        daysStack.constraint(to: topStack, with: [.top:.bottom], constant: 35)
        
        daysStack.shape(height: 120)
    }
}
