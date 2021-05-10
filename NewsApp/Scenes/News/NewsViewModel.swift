//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Ahmet Acar on 10.05.2021.
//


import Foundation

protocol NewsViewModelDelegate: class {
    func apiRequestCompleted()
}

final class NewsViewModel {
    
    weak var delegate: NewsViewModelDelegate?
    private var news: [Articles] = []
    private var service = NetworkManager()
    
    init(delegate: NewsViewModelDelegate) {
        self.delegate = delegate
        loadNews(key: nil, type: .listHeadlines, page: 1)
    }
    
    func loadNews(key: String?, type: ListType, page: Int) {
        service.getNews(keyWords: key ?? "home", page: page, type: type) { result in
            switch result {
            case .success(let news):
                self.news = news
                //self.loadData(data: news)
            case .failure(let error):
                print(error)
            }
            self.delegate?.apiRequestCompleted()
        }
    }

    
    
    func getNumberOfRows() -> Int {
        return news.count
    }
    
    func getData(row: Int) -> Articles {
        return news[row]
    }

}
