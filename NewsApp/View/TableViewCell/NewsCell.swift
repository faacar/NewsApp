//
//  NewsCell.swift
//  NewsApp
//
//  Created by Ahmet Acar on 11.05.2021.
//

import UIKit
import SnapKit

final class NewsCell: UITableViewCell {
    
    static let cellId = "newsCell"
    lazy var title: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.font = UIFont.boldSystemFont(ofSize: 16)
        return title
    }()
    lazy var newsDescription: UILabel = {
        let descLabel = UILabel()
        descLabel.numberOfLines = 0
        descLabel.font = UIFont.systemFont(ofSize: 15)
        return descLabel
    }()
    lazy var newsImage: UIImageView = {
        let image = UIImageView()
        image.sizeToFit()
        image.image = NewsImages.placeholder!
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
        contentView.addSubview(newsDescription)
        contentView.addSubview(newsImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        contentView.backgroundColor = .systemGray4
//        contentView.layer.masksToBounds = true
//        contentView.layer.cornerRadius = 15.0
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        newsDescription.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
        newsImage.snp.makeConstraints { (make) in
            make.top.equalTo(newsDescription.snp.top)
            make.left.equalTo(newsDescription.snp.right)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
}
