//
//  FoodDetails.swift
//  News
//
//  Created by Josicleison Elves on 16/08/1401 AP.
//

import UIKit

class FoodDetailsView: UIViewController {
    
    private var imageView: UIImageView
    
    init(_ image: UIImage?) {
        
        self.imageView = Create.imageView(image)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(imageView)
        view.backgroundColor = .black
        
        imageView.constraint(by: [.top,.leading,.trailing,.bottom])
    }
}
