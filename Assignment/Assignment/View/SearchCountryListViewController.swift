//
//  SearchCountryListViewController.swift
//  Assignment
//

import UIKit

protocol SearchCountryListViewControllerDelegate: AnyObject {
    func didSearchButtonTap()
    func didUpdateSearchResults(_ searchText: String)
}

final class SearchCountryListViewController: UISearchController {
    weak var searchDelegate: SearchCountryListViewControllerDelegate?
    override init(searchResultsController: UIViewController? = nil) {
        super.init(searchResultsController: searchResultsController)
        
        self.obscuresBackgroundDuringPresentation = false
        self.searchBar.placeholder = "Search here..."
        self.searchBar.delegate = self
        self.searchResultsUpdater = self
        self.definesPresentationContext = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchCountryListViewController: UISearchBarDelegate {
    // MARK: - UISearchBarDelegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.isActive = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Dismiss the search controller
        self.isActive = false
        guard let searchDelegate = searchDelegate else {
            return
        }
        searchDelegate.didSearchButtonTap()
    }
}

extension SearchCountryListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchDelegate = searchDelegate,
              let searchText = searchController.searchBar.text,
              !searchText.isEmpty else {
           
            return
        }
        searchDelegate.didUpdateSearchResults(searchText)
    }
}
