//
//  NewsCellViewModel.swift
//  News
//
//  Created by Josicleison on 10/10/22.
//

import Foundation

class NewsCellViewModel {
    
    let title: String
    let subTitle: String
    let imageURL: String?
    var imageData: Data? = nil
    
    init(title: String,
         subTitle: String,
         imageURL: String?) {
        
        self.title = title
        self.subTitle = subTitle
        self.imageURL = imageURL
    }
}
