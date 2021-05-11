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
    
    let cache = NSCache<NSString, UIImage>()
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
        print("URLLLLL---\(url)")
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
    
    func downloadImage(from urlString: String, completionHandler: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completionHandler(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completionHandler(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data)
            else {
                completionHandler(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completionHandler(image)
        }
        task.resume()
    }
}

