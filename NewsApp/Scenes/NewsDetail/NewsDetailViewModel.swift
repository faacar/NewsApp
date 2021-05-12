//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Ahmet Acar on 12.05.2021.
//

import UIKit.UIImage
import Foundation

protocol NewsDetailViewModelDelegate: class {
    func apiRequestCompleted()
}

final class NewsDetailViewModel {
    
    weak var delegate: NewsDetailViewModelDelegate?
    private var service = NetworkManager()

    //private var service = NetworkManager()
    var news: Articles?
    
//    init(delegate: NewsDetailViewModelDelegate) {
//        self.delegate = delegate
//    }
    
    func loadImage(newsImageString: String) -> UIImage {
        var imageResult: UIImage?
        service.downloadImage(from: newsImageString) { (image) in
            imageResult = image
        }
        return imageResult ?? NewsImages.placeholder!
    }
    
}
