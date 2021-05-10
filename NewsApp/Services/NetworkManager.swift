//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Ahmet Acar on 10.05.2021.
//

import UIKit

enum ListType {
    case search
    case listHeadlines
}


final class NetworkManager {
    //https://newsapi.org/v2/everything?q=besiktas&page=1&apiKey=44f5a016b63440daa678e233a475b97f
    //https://newsapi.org/v2/top-headlines?country=tr&apiKey=44f5a016b63440daa678e233a475b97f
    private let baseURL = "https://newsapi.org/v2"
    private let apiKey = "44f5a016b63440daa678e233a475b97f"

    func getNews(keyWords: String, page: Int, type: ListType, completionHandler: @escaping (Result<[Articles], NewsError>) -> Void) {
        let searchEndPoint = "\(baseURL)/everything?q=\(keyWords)&page=\(page)&apiKey=\(apiKey)"
        let headlinesEndPoint = "\(baseURL)/top-headlines?country=tr&apiKey=\(apiKey)"
        
        let stringForUrl = type == .listHeadlines ? headlinesEndPoint : searchEndPoint
        
        guard let url = URL(string: stringForUrl) else {
            completionHandler(.failure(.invalidUsername))
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error == nil && data != nil {
                let decoder = JSONDecoder()

                do {
                    let news = try decoder.decode(NewsModel.self, from: data!)
                    completionHandler(.success(news.articles))

                } catch {
                    completionHandler(.failure(.invalidData))
                }

            }
        }
        dataTask.resume()
    }
}

