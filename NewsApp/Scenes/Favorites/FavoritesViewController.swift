//
//  FavoritesViewController.swift
//  NewsApp
//
//  Created by Ahmet Acar on 10.05.2021.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = FavoritesViewModel()
        let result = viewModel.favoritedNews
        result.forEach { (res) in
            print(res.title)
        }
        view.backgroundColor = .systemOrange
        // Do any additional setup after loading the view.
    }
    

}
