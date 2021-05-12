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

    var news: Articles?
}
