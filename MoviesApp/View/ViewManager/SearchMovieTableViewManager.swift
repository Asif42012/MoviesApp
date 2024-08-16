//
//  SearchMovieTableViewManager.swift
//  MoviesApp
//
//  Created by Asif Hussain on 15/08/2024.
//

import UIKit

protocol MovieSearchViewDataSource: AnyObject {
    var tableRows: [TableViewSection] { get }
}

class SearchMovieTableViewManager: NSObject {
    
    let tableView: UITableView
    private weak var dataSource: MovieSearchViewDataSource?
    
    init(dataSource: MovieSearchViewDataSource) {
        self.dataSource = dataSource
        self.tableView = UITableView(frame: .zero)
        super.init()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(WatchListTableCell.self, forCellReuseIdentifier: WatchListTableCell.identifier)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func attachTableView(to view: UIView, topView: UIView? = nil) {
        view.addSubview(tableView)
        var topAnchorConstraint: NSLayoutConstraint
        if let topView = topView {
            topAnchorConstraint = tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20)
        } else {
            topAnchorConstraint = tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        }
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topAnchorConstraint,
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SearchMovieTableViewManager: UITableViewDelegate {
    
}

extension SearchMovieTableViewManager: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.tableRows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.tableRows[section].items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = dataSource?.tableRows[indexPath.section] else {
            return UITableViewCell()
        }
        return section.items[indexPath.row].cellForItem(at: indexPath, in: tableView)
    }
}
