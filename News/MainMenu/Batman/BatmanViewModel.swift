//
//  BatmanViewModel.swift
//  News
//
//  Created by Josicleison Elves on 13/08/1401 AP.
//

import UIKit

class BatmanViewModel {
    
    var batman: Batman? = nil
    
    func setupCollectionView(_ collectionView: UICollectionView) {
        
        Task {[weak self] in
            
            guard let data = await Network.Async.call(from: Network.EndPoints.omdbapi) else {return}
            
            
            guard let batman = Network.Async.decode(Batman.self, from: data) else {return}
            
            self?.batman = batman
            await collectionView.reloadData()
        }
    }
    
    func setupCell(_ cell: UICollectionViewCell, section: Search?) {
        
        guard let section = section else {return}
        
        Task {
            
            guard let data = await Network.Async.call(from: section.Poster, withKey: false) else {return}
            
            let imageView = await UIImageView(image: UIImage(data: data))
            
            await cell.contentView.addSubview(imageView)
            
            await imageView.constraint(by: [.top,.leading,.trailing,.bottom])
        }
    }
}
