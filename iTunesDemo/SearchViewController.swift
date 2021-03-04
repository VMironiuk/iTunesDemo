//
//  ViewController.swift
//  iTunesDemo
//
//  Created by Vladimir Mironiuk on 01.03.2021.
//

import UIKit

class SearchViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let baseURL = "https://itunes.apple.com/search?"
    
    private let networkManager = NetworkManager()
    
    private var searchBar: UISearchBar!
    
    private var itunesResponse: ItunesResponse?
    
    private var urlParameters: [String : String] {
        ["media" : "music", "entity" : "song", "term" : "\(searchBar.text ?? "")"]
    }

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
        networkManager.request(baseURL,
                               of: ItunesResponse.self,
                               parameters: urlParameters) { [weak self] response in
            self?.itunesResponse = response.value
            self?.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
