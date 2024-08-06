//
//  MovieSearchController.swift
//  MoviesApp
//
//  Created by Asif Hussain on 24/07/2024.
//

import UIKit

class MovieSearchController: BaseViewController {
    var coordinator: MainCoordinator?
    var viewModel = MovieSearchViewViewModel()
    
    let noResultFoundsView = EmptySearchResults()
    let searchBarContainer: UIView = {
        let searchBarContainer = UIView()
        searchBarContainer.translatesAutoresizingMaskIntoConstraints = false
        return searchBarContainer
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.contentMode = .center
        searchBar.sizeToFit()
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = UIColor(red: 103/255, green: 104/255, blue: 109/255, alpha: 1)
        searchBar.layer.cornerRadius = 10
        searchBar.layer.masksToBounds = true
        searchBar.searchTextField.borderStyle = .none
        if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField {
            if let searchIcon = UIImage(systemName: "magnifyingglass") {
                textFieldInsideSearchBar.rightView = UIImageView(image: searchIcon)
                textFieldInsideSearchBar.rightViewMode = .always
                textFieldInsideSearchBar.font = AppFont.regularPoppin14
                textFieldInsideSearchBar.textColor = .white
                textFieldInsideSearchBar.textAlignment = .left
            }
        }
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Search"
        titleLabel.textColor = .white
        titleLabel.font = AppFont.regularPoppin16
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let backButton: UIButton = {
        let backButton = UIButton()
        if let image = UIImage(systemName: "arrow.left") {
            backButton.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        backButton.tintColor = .white
        backButton.contentMode = .center
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    let helpButton: UIButton = {
        let helpButton = UIButton()
        if let image = UIImage(systemName: "exclamationmark.circle") {
            helpButton.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        helpButton.tintColor = .white
        helpButton.contentMode = .center
        helpButton.translatesAutoresizingMaskIntoConstraints = false
        return helpButton
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WatchListTableCell.self, forCellReuseIdentifier: WatchListTableCell.identifier)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        configureUi()
        configureTableView()
        configureViewModel()
    }
    
    private func configureViewModel(){
        viewModel.delegate = self
        viewModel.searchListDelegate = self
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureUi() {
        view.backgroundColor = AppFont.tabBackgroundColor
        title = "Search"
        addSubViews()
        addConstrains()
        initialResponder()
    }
    
    private func initialResponder(){
        searchBar.becomeFirstResponder()
        noResultFoundsView.isHidden = true
    }
    
    private func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        view.addSubview(helpButton)
        view.addSubview(searchBarContainer)
        searchBarContainer.addSubview(searchBar)
        view.addSubview(noResultFoundsView)
        view.addSubview(tableView)
    }
    private func addConstrains() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            helpButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            helpButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            searchBarContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchBarContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            searchBarContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchBarContainer.heightAnchor.constraint(equalToConstant: 42),
            
            searchBar.leadingAnchor.constraint(equalTo: searchBarContainer.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: searchBarContainer.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: searchBarContainer.topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: searchBarContainer.bottomAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            noResultFoundsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            noResultFoundsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            noResultFoundsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultFoundsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension MovieSearchController: UITableViewDelegate{
    
}

extension MovieSearchController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.searchResultRows.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < viewModel.searchResultRows.count else {
            return 0
        }
        return viewModel.searchResultRows[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section < viewModel.searchResultRows.count,
              indexPath.row < viewModel.searchResultRows[indexPath.section].items.count else {
            return UITableViewCell()
        }
        return viewModel.searchResultRows[indexPath.section].items[indexPath.row].cellForItem(at: indexPath, in: tableView)
    }
}

extension MovieSearchController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        return viewModel.queryMovies(with: searchText)
    }
}

extension MovieSearchController: MovieSearchViewViewModelDelegate{
    func movieSearchViewModelNoResultsFound() {
        tableView.isHidden = true
        noResultFoundsView.isHidden = false
    }
    
    func movieSearchViewModelReloadData() {
        tableView.reloadData()
    }
}

extension MovieSearchController: WatchListMovieTableViewRowItemDelegate{
    func WatchListMovieTableViewRowItemDelegate(cell: WatchListTableCell, rowItem: WatchListMovieCellItem) {
        coordinator?.showMovieDetailsFromWatchList(rowItem.item)
    }
}
