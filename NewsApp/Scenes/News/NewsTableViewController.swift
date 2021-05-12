//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Ahmet Acar on 10.05.2021.
//

import UIKit

final class NewsTableViewController: UIViewController {
    
    var tableView = UITableView()
    var viewModel = NewsViewModel()
    var searchedText: String = ""
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        configureTableView()
        showLoadingView()
        configureSearchController()

        viewModel.delegate = self
        viewModel.loadNews(key: nil, type: .listHeadlines, page: 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureNavigationController() {
        
        title = "Appcent News App"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.black
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search different news"
        navigationItem.searchController = searchController
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
        let cellItem = viewModel.news[indexPath.row]
        cell.selectionStyle = .none
        cell.title.text = cellItem.title
        cell.newsDescription.text = cellItem.description
        cell.newsImage.image = viewModel.loadImage(newsImageString: cellItem.image ?? "")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//TODO: - Fix the bug (When i going to the new page and coming back, the data page is not updated.)
        let destinationVc = NewsDetailViewController()
        destinationVc.viewModel.news = viewModel.news[indexPath.row]
        navigationController?.pushViewController(destinationVc, animated: true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            page += 1
            viewModel.loadNews(key: searchedText, type: .search, page: page)
        }
    }
}

//MARK: - Extension UISearchResultsUPdating & UISearchControllerDelegate

extension NewsTableViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchedText = searchText
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchNewText), object: nil)
        perform(#selector(self.searchNewText), with: nil, afterDelay: 0.5)
    }
    
    @objc private func searchNewText(text: String) {
        if self.searchedText.count > 3 {
            viewModel.news = []
            viewModel.loadNews(key: searchedText, type: .search, page: page)
        }
    }
}
