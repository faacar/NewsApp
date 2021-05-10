//
//  NewsModel.swift
//  NewsApp
//
//  Created by Ahmet Acar on 10.05.2021.
//

import Foundation
// Sample: https://newsapi.org/v2/everything?q=besiktas&page=1&apiKey=44f5a016b63440daa678e233a475b97f

struct NewsModel: Codable {
    let articles: [Articles]
}

struct Articles: Codable {
    let author: String?
    let title: String?
    let description: String?
    let publishDate: String?
    let content: String?
    let image: String?
    let urlLink: String?
    
    enum CodingKeys: String, CodingKey {
        case author = "author"
        case title = "title"
        case description = "description"
        case publishDate = "publishedAt"
        case content = "content"
        case image = "urlToImage"
        case urlLink = "url"
    }
}



 
