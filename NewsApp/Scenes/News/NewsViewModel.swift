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
    
    let cache = NSCache<NSString, UIImage>()

    weak var delegate: NewsViewModelDelegate?
    private var news: [Articles] = []
    
    private var filteredNews: [Articles] = []    
    private var service = NetworkManager()
    
    init(delegate: NewsViewModelDelegate) {
        self.delegate = delegate
        loadNews(key: nil, type: .listHeadlines, page: 1)
    }
    
    func loadNews(key: String?, type: ListType, page: Int) {
        service.getNews(keyWords: key ?? "home", page: page, type: type) { result in
            self.delegate?.apiRequestCompleted()
            switch result {
            case .success(let news):
                self.news = news
                //self.loadData(data: news)
            case .failure(let error):
                print(error)
            }
        }
    }

    func loadImage(newsImageString: String) -> UIImage? {
        var imageResult: UIImage?
        service.downloadImage(from: newsImageString) { (image) in
            imageResult = image
        }
        return imageResult
    }

    func getNumberOfRows(isSearched: Bool) -> Int {
        return isSearched ? filteredNews.count : news.count
    }

    
    func setFilteredData(filteredData: [Articles]) {
        filteredNews = filteredData
    }
    
    func getFilteredData(row: Int) -> Articles {
        return filteredNews[row]
    }
    
    func getData(row: Int) -> Articles {
        return news[row]
    }
    
    func getData() -> [Articles] {
        return news
    }

}
