//
//  NewsTabBarController.swift
//  NewsApp
//
//  Created by Ahmet Acar on 13.05.2021.
//

import UIKit

final class NewsTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .black
        viewControllers = [createNewsVC(), createFavoritesVC()]
    }

    private func createNewsVC() -> UINavigationController {
        let newsVC = NewsTableViewController()
        newsVC.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: NewsImages.newsImageSF), tag: 0)
        return UINavigationController(rootViewController: newsVC)
    }
    
    private func createFavoritesVC() -> UINavigationController {
        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: NewsImages.favoritesImageSF), tag: 1)
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    
}
