//
//  MovieWatchListController.swift
//  MoviesApp
//
//  Created by Asif Hussain on 24/07/2024.
//

import UIKit

class MovieWatchListController: BaseViewController {
    var coordinator: MainCoordinator?
    private let viewModel: WatchListControllerViewModel
    
    init(viewModel: WatchListControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let noMovieView = CenterContentView()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WatchListTableCell.self, forCellReuseIdentifier: WatchListTableCell.identifier)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "WatchList"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        configureViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViewModel()
    }
}

extension MovieWatchListController{
    
    private func configureViewModel() {
        viewModel.fetchData()
        viewModel.delegate = self
        viewModel.watchListDelegate = self
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureUI() {
        view.backgroundColor = AppFont.tabBackgroundColor
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(noMovieView)
        view.addSubview(tableView)
        setUpConstraint()
        noMovieView.isHidden = true
    }
    
    private func updateUIForWatchlist() {
        let hasMovies = !viewModel.watchListTableRows.isEmpty && !viewModel.watchListTableRows[0].items.isEmpty
        tableView.isHidden = !hasMovies
        noMovieView.isHidden = hasMovies
    }
    
    private func setUpConstraint() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            noMovieView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            noMovieView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            noMovieView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noMovieView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension MovieWatchListController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MovieWatchListController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.watchListTableRows.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < viewModel.watchListTableRows.count else {
            return 0
        }
        return viewModel.watchListTableRows[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section < viewModel.watchListTableRows.count,
              indexPath.row < viewModel.watchListTableRows[indexPath.section].items.count else {
            return UITableViewCell()
        }
        return viewModel.watchListTableRows[indexPath.section].items[indexPath.row].cellForItem(at: indexPath, in: tableView)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension MovieWatchListController: WatchListControllerViewModelDelegate{
    func watchListControllerViewModel() {
        updateUIForWatchlist()
        tableView.reloadData()
    }
}

extension MovieWatchListController: WatchListMovieTableViewRowItemDelegate{
    func WatchListMovieTableViewRowItemDelegate(cell: WatchListTableCell, rowItem: WatchListMovieCellItem) {
        coordinator?.showMovieDetailsFromWatchList(rowItem.item)
    }
}
