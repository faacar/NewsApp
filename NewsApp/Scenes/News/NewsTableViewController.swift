//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Ahmet Acar on 10.05.2021.
//

import UIKit

final class NewsTableViewController: UIViewController {
    
    var tableView = UITableView()
    var viewModel: NewsViewModel!
    var filteredNews: [Articles] = []
    var isSearched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        showLoadingView()
        configureSearchController()
        title = "Appcent News App"
        viewModel = NewsViewModel(delegate: self)
        viewModel?.loadNews(key: "uk", type: .search, page: 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
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
        //let cellItem = viewModel.getData(row: indexPath.row)
        let cellItem: Articles?
        if isSearched {
            cellItem = viewModel.getFilteredData(row: indexPath.row)
        } else {
            cellItem = viewModel.getData(row: indexPath.row)
        }
        
        cell.title.text = cellItem?.title
        cell.newsDescription.text = cellItem?.description
        cell.newsImage.image = viewModel.loadImage(newsImageString: cellItem?.image ?? "")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//TODO: - Fix the bug (When i going to the new page and coming back, the data page is not updated.)
        let destinationVc = FavoritesViewController()
        navigationController?.pushViewController(destinationVc, animated: true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows(isSearched: isSearched) ?? 0
    }
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//    }
}

//MARK: - Extension UISearchResultsUPdating & UISearchControllerDelegate

extension NewsTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else { return }
        print(searchText)
        let res = viewModel.getData().filter { ($0.title?.lowercased().contains(searchText.lowercased()) ?? false) }
        
        viewModel.setFilteredData(filteredData: res)
        isSearched = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearched = false
        tableView.reloadData()
    }
}
