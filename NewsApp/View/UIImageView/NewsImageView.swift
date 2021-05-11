//
//  NewsImageView.swift
//  NewsApp
//
//  Created by Ahmet Acar on 11.05.2021.
//

import UIKit

class NewsImageView: UIImageView {

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        image = NewsImages.placeholder
        clipsToBounds = true
        layer.cornerRadius = 10
        //layer.borderWidth = 2.0
        //layer.borderColor = LFColors.cellBorderColor?.cgColor
        sizeToFit()
    }
}
