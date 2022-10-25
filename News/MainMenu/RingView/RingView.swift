//
//  RingView.swift
//  News
//
//  Created by Josicleison on 25/10/22.
//

import UIKit

class RingView: UIViewController {
    
    private let label = Create.label("Calorie Goal")
    
    private let track: CAShapeLayer = {
        
        let track = CAShapeLayer()
        track.fillColor = UIColor.clear.cgColor
        track.lineWidth = 15
        track.strokeColor = UIColor.lightGray.cgColor
        
        return track
    }()
    
    private let shape: CAShapeLayer = {
        
        let shape = CAShapeLayer()
        shape.lineWidth = 15
        shape.strokeColor = UIColor.blue.cgColor
        shape.strokeEnd = 0
        shape.fillColor = UIColor.clear.cgColor
        
        return shape
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "\(type(of: self))"
        
        let circle = UIBezierPath(arcCenter: view.center,
                                  radius: 150,
                                  startAngle: -(.pi/2),
                                  endAngle: .pi*2,
                                  clockwise: true)
        
        shape.path = circle.cgPath
        track.path = circle.cgPath
        
        let button = button()
        
        label.sizeToFit()
        
        view.layer.addSublayers([track, shape])
        view.addSubviews([button, label])
        view.backgroundColor = .systemIndigo
        
        button.constraint(by: [.centerX,.centerY])
        label.constraint(to: view.safeAreaLayoutGuide,
                         [.leading: 20,.trailing: -20,.top: 0])
    }
    
    private func button(_ title: String = "Toca Aqui") -> UIButton {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 3
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        
        return Create.button(title) {_ in
            
            self.shape.add(animation, forKey: "animation")
        }
    }
}
