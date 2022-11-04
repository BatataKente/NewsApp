//
//  BatmanView.swift
//  News
//
//  Created by Josicleison Elves on 13/08/1401 AP.
//

import UIKit

class BatmanView: UIViewController {
    
    private let batmanViewModel = BatmanViewModel()
    
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private let label = Create.label(alignment: .center)
    
    private let pageControl: UIPageControl = {
        
        let pageControl = UIPageControl()
        pageControl.isUserInteractionEnabled = false
        
        return pageControl
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "\(type(of: self))"
        
        view.addSubviews([collectionView, label, pageControl])
        view.backgroundColor = .black
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView.constraint(to: view.safeAreaLayoutGuide, by: [.top,.leading,.trailing,.bottom])
        
        label.constraint(by: [.leading,.trailing])
        label.constraint(to: pageControl, with: [.bottom:.top])
        
        pageControl.constraint(to: collectionView, by: [.leading,.trailing,.bottom])
        
        batmanViewModel.setupCollectionView(collectionView)
    }
}

extension BatmanView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let section = batmanViewModel.batman?.Search?[indexPath.row] else {return}
        navigationController?.pushViewController(BatmanDetailsView(section), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        pageControl.numberOfPages = batmanViewModel.batman?.Search?.count ?? 0
        label.text = batmanViewModel.batman?.Search?.first?.Title
        return batmanViewModel.batman?.Search?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        batmanViewModel.setupCell(cell, section: batmanViewModel.batman?.Search?[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width,
                      height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let currentPageIndex = Int((scrollView.contentOffset.x + (view.frame.width/2))/view.frame.width)
        
        if currentPageIndex > 0 && currentPageIndex < batmanViewModel.batman?.Search?.count ?? 0 {
            
            pageControl.currentPage = currentPageIndex
            
            label.text = batmanViewModel.batman?.Search?[currentPageIndex].Title
        }
    }
}
