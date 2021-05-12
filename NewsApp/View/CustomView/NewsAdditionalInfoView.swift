//
//  NewsAdditionalInfoView.swift
//  NewsApp
//
//  Created by Ahmet Acar on 12.05.2021.
//

import UIKit.UIView
import SnapKit

enum ContentType {
    case authorInfoView
    case dateView
}

final class NewsAdditionalInfoView: UIView {
    
    private lazy var symbolImage: UIImageView = {
        let image = UIImageView()
        image.sizeToFit()
        image.tintColor = .black
        return image
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    

    
    init(text: String, contentType: ContentType) {
        super.init(frame: .zero)
        if contentType == .authorInfoView {
            symbolImage.image = UIImage(systemName: NewsImages.authorLaptopImageSF)
            textLabel.text = text
        } else {
            symbolImage.image = UIImage(systemName: NewsImages.calendarImageSF)
            textLabel.text = text.convertToDisplayFormat()
        }
        
        layer.cornerRadius = 15.0
        layer.masksToBounds = true
        backgroundColor = .systemGray4
        
        addSubview(symbolImage)
        addSubview(textLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        symbolImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.14)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.left.equalTo(symbolImage.snp.right).offset(8)
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }
}
