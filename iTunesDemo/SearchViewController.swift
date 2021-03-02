//
//  ViewController.swift
//  iTunesDemo
//
//  Created by Vladimir Mironiuk on 01.03.2021.
//

import UIKit

class SearchViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var searchBar: UISearchBar!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    
    // MARK: - Private
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        searchBar.delegate = self
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("\(#function): \(searchBar.text ?? "")")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
