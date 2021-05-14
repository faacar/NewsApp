//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Ahmet Acar on 12.05.2021.
//

import UIKit
import CoreData

final class NewsDetailViewModel {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var service = NetworkManager()

    var news: Articles?
}

//MARK: - Core Data
extension NewsDetailViewModel {
    
    func favoriteNews() {
        let newFavoriteNews = FavoriteNewsItem(context: context)
        newFavoriteNews.author = news?.author
        newFavoriteNews.content = news?.content
        newFavoriteNews.image = news?.image
        newFavoriteNews.newsDescription = news?.description
        newFavoriteNews.publishDate = news?.publishDate
        newFavoriteNews.title = news?.title
        newFavoriteNews.urlLink = news?.urlLink
        
        do {
            try context.save()
            
        } catch {
            print("coreData error")
        }
    }
}
