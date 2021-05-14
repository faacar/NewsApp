//
//  NewsEmptyStateView.swift
//  NewsApp
//
//  Created by Ahmet Acar on 14.05.2021.
//

import UIKit
import SnapKit

final class NewsEmptyStateView: UIView {
    
//MARK: - Properties
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.numberOfLines = 2
        title.textColor = .systemGray2
        title.font = UIFont.systemFont(ofSize: 20)
        title.textAlignment = .center
        return title
    }()
    
    lazy var messageLabel: UILabel = {
        let message = UILabel()
        message.numberOfLines = 3
        message.textColor = .systemGray3
        message.font = UIFont.systemFont(ofSize: 19)
        message.textAlignment = .center
        return message
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: NewsImages.circleHeartImageSF)
        image.tintColor = .systemGray2
        image.sizeToFit()
        return image
    }()
    
//MARK: - Life Cycle
    init(title: String, message: String, image: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        messageLabel.text = message
        imageView.image = UIImage(systemName: image) ?? UIImage(named: image)
        
        addSubview(titleLabel)
        addSubview(messageLabel)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.25)
            make.width.equalTo(imageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.08)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.10)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
    }
}
