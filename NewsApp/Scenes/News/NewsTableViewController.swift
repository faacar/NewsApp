//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Ahmet Acar on 10.05.2021.
//

import UIKit

final class NewsTableViewController: UIViewController, NewsViewModelDelegate {
    
    func apiRequestCompleted() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            //self.stopLoading()
        }
    }
    

    var tableView = UITableView()
    var viewModel: NewsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "newsList")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .systemRed
        tableView.rowHeight = 60
        
        //configureTableView()
        viewModel = NewsViewModel(delegate: self)
        view.backgroundColor = .systemYellow
        viewModel?.loadNews(key: "istanbul", type: .search, page: 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureTableView() {
        //tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.cellId)
    }

    // MARK: - Table view data source
}

extension NewsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsList",for: indexPath)
        let cellItem = viewModel?.getData(row: indexPath.row)
        cell.textLabel?.text = cellItem?.title!
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
