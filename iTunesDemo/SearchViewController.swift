//
//  ViewController.swift
//  iTunesDemo
//
//  Created by Vladimir Mironiuk on 01.03.2021.
//

import UIKit

class SearchViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let detailsSegueIdentifier = "DetailsView"
    
    private let baseURL = "https://itunes.apple.com/search?"
    
    private let networkManager = NetworkManager()
    
    private var searchBar: UISearchBar!
    
    private var itunesResponse: ItunesResponse?
    
    private var selectedItunesResult: ItunesResult?
    
    private var urlParameters: [String : String] {
        ["media" : "music", "entity" : "song", "term" : "\(searchBar.text ?? "")"]
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailsSegueIdentifier {
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.iTunesResult = selectedItunesResult
        }
    }
    
    // MARK: - Private
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        searchBar.delegate = self
    }
    
    private func configCell(_ cell: ResultCell, with iTunesResult: ItunesResult?) {
        guard let iTunesResult = iTunesResult else {
            return
        }
        
        cell.config(with: iTunesResult)
        networkManager.request(iTunesResult.artworkMiniature) { [weak self] response in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    cell.displayImage(image)
                }
            case .failure(let error):
                self?.showError(with: error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itunesResponse?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ResultCell
        configCell(cell, with: itunesResponse?.results[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedItunesResult = itunesResponse?.results[indexPath.row]
        performSegue(withIdentifier: detailsSegueIdentifier, sender: self)
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        networkManager.request(baseURL,
                               of: ItunesResponse.self,
                               parameters: urlParameters) { [weak self] response in
            switch response.result {
            case .success(let iTunesResponse):
                self?.itunesResponse = iTunesResponse
                self?.tableView.reloadData()
            case .failure(let error):
                self?.showError(with: error.localizedDescription)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
