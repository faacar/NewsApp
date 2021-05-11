//
//  UIImageView+Ext.swift
//  NewsApp
//
//  Created by Ahmet Acar on 11.05.2021.
//

import UIKit.UIImageView

extension UIImageView {
    
    func load(stringURL: String?) {
        guard let url = URL(string: stringURL ?? "") else {
            return image = NewsImages.placeholder
        }
        
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                    self.image = image
            } else {
                image = NewsImages.placeholder
            }
        }
    }
}
