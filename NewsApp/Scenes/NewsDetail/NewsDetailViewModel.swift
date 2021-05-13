//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Ahmet Acar on 12.05.2021.
//

import UIKit
import CoreData

protocol NewsDetailViewModelDelegate: class {
    func apiRequestCompleted()
}

final class NewsDetailViewModel {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    weak var delegate: NewsDetailViewModelDelegate?
    private var service = NetworkManager()

    var news: Articles?
    var savedNews: [FavoriteNewsItem] = []//

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
            
        }
    }
    
    func getResult() {//
        do {
            savedNews = try context.fetch(FavoriteNewsItem.fetchRequest())
            print(savedNews[0].title)
        } catch {
            
        }
    }
}
