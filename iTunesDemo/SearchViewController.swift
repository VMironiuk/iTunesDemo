//
//  ViewController.swift
//  iTunesDemo
//
//  Created by Vladimir Mironiuk on 01.03.2021.
//

import UIKit

class SearchViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let baseURL = "https://itunes.apple.com/search?media=music&entity=song&term="
    
    private let networkManager = NetworkManager()
    
    private var searchBar: UISearchBar!
    
    private var itunesResponse: ItunesResponse?

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
        itunesResponse?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ResultCell
        cell.config(with: itunesResponse?.results[indexPath.row])
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard var termToSearch = searchBar.text else {
            return
        }
        
        termToSearch = termToSearch.replacingOccurrences(of: " ", with: "+")
        networkManager.request("\(baseURL)\(termToSearch)") { [weak self] response in
            debugPrint(response)
            self?.itunesResponse = response.value
            self?.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
