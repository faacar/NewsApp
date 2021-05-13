//
//  FavoritesViewModel.swift
//  NewsApp
//
//  Created by Ahmet Acar on 13.05.2021.
//

import UIKit
import CoreData

final class FavoritesViewModel {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favoritedNews: [FavoriteNewsItem] = []
    
    init() {
        getFavoritedNews()
    }
    
    func getFavoritedNews() {
        do {
            favoritedNews = try context.fetch(FavoriteNewsItem.fetchRequest())
        } catch {
            
        }
    }
    
}
