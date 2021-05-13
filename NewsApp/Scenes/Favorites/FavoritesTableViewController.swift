//
//  FavoritesTableViewController.swift
//  NewsApp
//
//  Created by Ahmet Acar on 10.05.2021.
//

import UIKit

class FavoritesTableViewController: UIViewController {

    var tableView = UITableView()
    let viewModel = FavoritesTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        view.backgroundColor = .systemOrange
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        viewModel.getFavoritedNews()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        title = "Favorites"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.cellId)
        tableView.rowHeight = 140
    }

}

extension FavoritesTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoritedNews.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.cellId, for: indexPath) as! NewsCell
        let cellItem = viewModel.favoritedNews[indexPath.row]
        cell.selectionStyle = .none
        cell.title.text = cellItem.title
        cell.newsDescription.text = cellItem.newsDescription
        cell.newsImage.load(stringURL: cellItem.image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel.deleteFavoriteNews(item: self.viewModel.favoritedNews[indexPath.row])
            viewModel.getFavoritedNews()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
