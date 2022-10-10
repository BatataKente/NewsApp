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
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String,
         subTitle: String,
         imageURL: URL?) {
        
        self.title = title
        self.subTitle = subTitle
        self.imageURL = imageURL
    }
}
