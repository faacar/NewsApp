//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Ahmet Acar on 10.05.2021.
//

import UIKit

final class NewsTableViewController: UIViewController {
    
    var tableView = UITableView()
    var viewModel: NewsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        showLoadingView()
        
        viewModel = NewsViewModel(delegate: self)
        viewModel?.loadNews(key: "uk", type: .search, page: 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.cellId)
        tableView.rowHeight = 140
    }
}

//MARK: - Edxtension NewsViewModelDelegate

extension NewsTableViewController: NewsViewModelDelegate {
    
    func apiRequestCompleted() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.dismissLoadingView()
        }
    }
}

// MARK: - Extension UITableViewDataSource & UITableViewDelegate

extension NewsTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.cellId,for: indexPath) as! NewsCell
        let cellItem = viewModel?.getData(row: indexPath.row)
        
        cell.title.text = cellItem?.title
        cell.newsDescription.text = cellItem?.description
        cell.newsImage.image = viewModel?.loadImage(newsImageString: cellItem?.image ?? "")

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows() ?? 0
    }
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//    }
}
