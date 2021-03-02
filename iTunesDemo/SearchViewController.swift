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
    
    private var searchResults = [SearchResult]()

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

// MARK: - UITableViewDataSource

extension SearchViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ResultCell
        cell.config(with: searchResults[indexPath.row])
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResults = search()
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

// MARK: - Searching (Temporary)

extension SearchViewController {
    
    private func search() -> [SearchResult] {
        return [
            SearchResult(artist: "R.E.M.",
                         album: "In Time: The Best of R.E.M. 1988-2003",
                         track: "Losing My Religion",
                         artwork: UIImage(systemName: "guitars")),
            SearchResult(artist: "R.E.M.",
                         album: "Document",
                         track: "It's the End of the World As We Know It (And I Feel Fine)",
                         artwork: UIImage(systemName: "guitars")),
            SearchResult(artist: "R.E.M.",
                         album: "In Time: The Best of R.E.M. 1988-2003",
                         track: "Everybody Hurts",
                         artwork: UIImage(systemName: "guitars"))
        ]
    }
}
