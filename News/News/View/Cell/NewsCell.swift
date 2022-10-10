//
//  Cell.swift
//  News
//
//  Created by Josicleison on 10/10/22.
//

import UIKit

class NewsCell: UITableViewCell {
    
    static let identifier = "Cell"
    
    private let newsTitleLabel = Create.label(font: .systemFont(ofSize: 20,
                                                                weight: .semibold))
    
    private let newsSubTitleLabel = Create.label(font: .systemFont(ofSize: 15,
                                                                   weight: .light))
    
    private let newsImageView: UIImageView = {
        
        let newsImageView = UIImageView()
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.clipsToBounds = true
        newsImageView.layer.cornerRadius = 5
        newsImageView.layer.masksToBounds = true
        newsImageView.backgroundColor = .secondarySystemBackground
        
        return newsImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews([newsImageView, newsTitleLabel, newsSubTitleLabel])
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        newsTitleLabel.constraint(by: [.top,.leading])
        newsTitleLabel.constraint(by: [.height], multiplier: 0.5)
        newsTitleLabel.constraint(by: [.width], multiplier: 0.6)
        
        newsSubTitleLabel.constraint(by: [.bottom,.leading])
        newsSubTitleLabel.constraint(by: [.height], multiplier: 0.5)
        newsSubTitleLabel.constraint(by: [.width], multiplier: 0.6)
        
        newsImageView.constraint([.top:5,.trailing:0,.bottom:0])
        newsImageView.constraint(by: [.width], multiplier: 0.4)
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        newsTitleLabel.text = nil
        newsSubTitleLabel.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel: NewsCellViewModel) {
        
        newsTitleLabel.text = viewModel.title
        newsSubTitleLabel.text = viewModel.subTitle
        if let data = viewModel.imageData {
            
            newsImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL {
            
            Network.callData(url) {[weak self] data in
                
                self?.newsImageView.image = UIImage(data: data)
            }
        }
    }
}
