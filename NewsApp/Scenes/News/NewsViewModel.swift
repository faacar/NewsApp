//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Ahmet Acar on 10.05.2021.
//


import Foundation
import UIKit.UIImageView

protocol NewsViewModelDelegate: class {
    func apiRequestCompleted()
}

final class NewsViewModel {
    

    weak var delegate: NewsViewModelDelegate?
    private var service = NetworkManager()
    
    var news: [Articles] = []
    
    func loadNews(key: String?, type: ListType, page: Int) {
        service.getNews(keyWords: key ?? "home", page: page, type: type) { result in
            self.delegate?.apiRequestCompleted()
            switch result {
            case .success(let news):
                page == 1 ? self.news = news : self.news.append(contentsOf: news)
            case .failure(let error):
                print(error)
            }
            
        }
    }

    func getNumberOfRows() -> Int {
        return news.count
    }
}
