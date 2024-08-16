//
//  MovieWatchListController.swift
//  MoviesApp
//
//  Created by Asif Hussain on 24/07/2024.
//

import UIKit

class MovieWatchListController: BaseViewController {
    
    private let coordinator: MainCoordinator
    private let viewModel: WatchListControllerViewModel
    
    private let noMovieView = CenterContentView()
    private var tableViewManager: SearchMovieTableViewManager?
    
    private let headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.saveButton.isHidden = true
        headerView.titleLabel.text = "WatchList"
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    init(coordinator: MainCoordinator ,viewModel: WatchListControllerViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViewModel()
    }
}

extension MovieWatchListController {
    
    private func configureViewModel() {
        viewModel.fetchData()
        viewModel.delegate = self
        viewModel.watchListDelegate = self
    }
    
    private func configureTableView() {
        tableViewManager = SearchMovieTableViewManager(dataSource: viewModel)
        tableViewManager?.attachTableView(to: view, topView: headerView)
    }
    
    private func configureUI() {
        view.backgroundColor = AppFont.tabBackgroundColor
        view.addSubview(headerView)
        view.addSubview(noMovieView)
        setUpConstraint()
        noMovieView.isHidden = false
        configureTableView()
    }
    
    private func updateUIForWatchlist() {
        let hasMovies = !viewModel.tableRows.isEmpty && !viewModel.tableRows[0].items.isEmpty
        tableViewManager?.tableView.isHidden = !hasMovies
        noMovieView.isHidden = hasMovies
    }
    
    private func setUpConstraint() {
        ConstraintsHelper.constrains(with: view, headerView: headerView, noMovieView: noMovieView)
    }
}

extension MovieWatchListController: WatchListControllerViewModelDelegate{
    func watchListControllerViewModel() {
        updateUIForWatchlist()
        tableViewManager?.reloadData()
    }
}

extension MovieWatchListController: WatchListMovieTableViewRowItemDelegate{
    func watchListMovieTableViewRowItemDelegate(cell: WatchListTableCell, rowItem: WatchListMovieCellItem) {
        coordinator.showMovieDetailsFromWatchList(rowItem.item)
    }
}
