//
//  MovieSearchController.swift
//  MoviesApp
//
//  Created by Asif Hussain on 24/07/2024.
//

import UIKit

class MovieSearchController: BaseViewController {
    private let coordinator: MainCoordinator
    private let viewModel: MovieSearchViewViewModel
    
    private let noResultFoundsView = EmptySearchResults()
    private let headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.saveButton.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
        headerView.titleLabel.text = "Search"
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    private let searchBarContainer: UIView = {
        let searchBarContainer = UIView()
        searchBarContainer.translatesAutoresizingMaskIntoConstraints = false
        return searchBarContainer
    }()
    
    private let searchBar: UISearchBar = {
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
    private var tableViewManager: SearchMovieTableViewManager?
    
    init(coordinator: MainCoordinator , viewModel: MovieSearchViewViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        headerView.delegate = self
        configureUi()
        configureViewModel()
    }
}

extension MovieSearchController {
    
    private func configureViewModel(){
        viewModel.delegate = self
        viewModel.searchListDelegate = self
    }
    
    private func configureTableView() {
        tableViewManager = SearchMovieTableViewManager(dataSource: viewModel)
        tableViewManager?.attachTableView(to: view, topView: searchBarContainer)
    }
    
    private func configureUi() {
        view.backgroundColor = AppFont.tabBackgroundColor
        title = "Search"
        addSubViews()
        addConstrains()
        configureTableView()
        initialResponder()
    }
    
    private func initialResponder(){
        searchBar.becomeFirstResponder()
        noResultFoundsView.isHidden = true
    }
    
    private func addSubViews() {
        view.addSubview(headerView)
        view.addSubview(searchBarContainer)
        searchBarContainer.addSubview(searchBar)
        view.addSubview(noResultFoundsView)
    }
    
    private func addConstrains() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            searchBarContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchBarContainer.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            searchBarContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchBarContainer.heightAnchor.constraint(equalToConstant: 42),
            
            searchBar.leadingAnchor.constraint(equalTo: searchBarContainer.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: searchBarContainer.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: searchBarContainer.topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: searchBarContainer.bottomAnchor),
            
            noResultFoundsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            noResultFoundsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            noResultFoundsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultFoundsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension MovieSearchController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        return viewModel.queryMovies(with: searchText)
    }
}

extension MovieSearchController: MovieSearchViewViewModelDelegate{
    func movieSearchViewModelNoResultsFound() {
        tableViewManager?.tableView.isHidden = true
        noResultFoundsView.isHidden = false
    }
    
    func movieSearchViewModelReloadData() {
        tableViewManager?.reloadData()
    }
}

extension MovieSearchController: WatchListMovieTableViewRowItemDelegate{
    func watchListMovieTableViewRowItemDelegate(cell: WatchListTableCell, rowItem: WatchListMovieCellItem) {
        coordinator.showMovieDetailsFromWatchList(rowItem.item)
    }
}

extension MovieSearchController: HeaderViewButtonDidTapDelegate {
    func backButtonDidTap() {
        coordinator.popViewController()
    }
    //Navigate to FAQs view
    func saveButtonDidTap() {
        coordinator.showFAQs()
    }
}
