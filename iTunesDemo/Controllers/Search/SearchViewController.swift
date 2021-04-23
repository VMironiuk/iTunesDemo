import UIKit
import Rswift

class SearchViewController: UITableViewController {

    // MARK: - Properties

    private var searchBar: UISearchBar!

    private lazy var presenter: SearchPresenter = SearchPresenter(view: self)

    var coordinator: (Coordinatable & SearchResultAction)?

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

    private func configCell(_ cell: ResultCell, with iTunesResult: ItunesResult?) {
        guard let iTunesResult = iTunesResult else {
            return
        }

        cell.config(with: iTunesResult)
        presenter.data(from: iTunesResult.artwork) { [weak cell] data in
            if let data = data {
                cell?.displayImage(UIImage(data: data))
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.countOfResults()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cell.identifier,
                                                       for: indexPath) as? ResultCell else {
            fatalError(R.string.localizable.resultCellInstantiationErrorMessage())
        }
        configCell(cell, with: presenter.results()[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItunesResult = presenter.results()[indexPath.row]
        coordinator?.searchResultDidSelect(selectedItunesResult)
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchTerm(searchBar.text ?? "")
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

// MARK: - SearchPresenterView

extension SearchViewController: SearchPresenterView {

    func refresh() {
        tableView.reloadData()
    }

    func showErrorMessage(_ message: String) {
        showError(with: message)
    }
}
