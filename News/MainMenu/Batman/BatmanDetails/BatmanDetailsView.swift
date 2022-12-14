//
//  BatmanDetails.swift
//  News
//
//  Created by Josicleison Elves on 13/08/1401 AP.
//

import UIKit

class BatmanDetailsView: UIViewController {
    
    private let section: Search
    
    init(_ section: Search) {
        
        self.section = section
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    struct FreeImages: Codable {
        
        let html: String
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = section.Title
        
        view.backgroundColor = .black
    }
}
