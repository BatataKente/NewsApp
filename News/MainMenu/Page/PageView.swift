//
//  PageView.swift
//  News
//
//  Created by Josicleison Elves on 13/08/1401 AP.
//

import UIKit

class PageView: UIViewController {
    
    private var images: [String] = []
    
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemPink
        
        return collectionView
    }()
    
    private let textField = Create.textField(placeholder: "Search")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "\(type(of: self))"
        
        let button = Create.button(image: Assets.Images.right) {_ in
            
            self.search(self.textField.text)
        }
        
        let stackView = UIStackView(arrangedSubviews: [textField, button])
        stackView.distribution = .fillProportionally
        
        view.addSubviews([collectionView, stackView])
        view.backgroundColor = .systemPink
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView.constraint(to: view.safeAreaLayoutGuide, by: [.top,.leading,.trailing,.bottom])
        
        stackView.constraint(to: collectionView, [.leading:20,.trailing:-20,.bottom:-20])
        
        search()
    }
    
    func search(_ what: String? = "fall") {
        
        view.isUserInteractionEnabled = false
        
        Network.call("https://www.freeimages.com/search/\(what ?? "")") {[weak self] data in
            
            guard let html = String(data: data, encoding: .ascii) else {return}
            
            var images: [String] = []
            
            for string in html.split(separator: "\"") {
                
                if string.contains(".png") || string.contains(".jpg") {
                    
                    images.append(String(string))
                }
            }
            
            self?.images = images
            self?.collectionView.reloadData()
            self?.view.isUserInteractionEnabled = true
        }
    }
}

extension PageView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        Network.call(images[indexPath.row]) {data in
            
            let imageView = UIImageView(image: UIImage(data: data))
            imageView.contentMode = .center
            imageView.clipsToBounds = true
            
            let stack = UIStackView(arrangedSubviews: [imageView])
            stack.backgroundColor = .systemMint
            
            cell.contentView.addSubview(stack)
            
            stack.constraint(by: [.top,.leading,.trailing,.bottom])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width,
                      height: collectionView.frame.height)
    }
}
