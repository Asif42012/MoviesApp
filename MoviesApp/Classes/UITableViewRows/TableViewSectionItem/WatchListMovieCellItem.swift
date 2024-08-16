//
//  File.swift
//  MoviesApp
//
//  Created by Asif Hussain on 02/08/2024.
//

import Foundation
import UIKit


protocol WatchListMovieTableViewRowItemDelegate: AnyObject{
    func watchListMovieTableViewRowItemDelegate(cell: WatchListTableCell, rowItem: WatchListMovieCellItem)
}

final class WatchListMovieCellItem: TableViewCellItem {
    let item: MovieDetails
    weak var delegate: WatchListMovieTableViewRowItemDelegate? = nil
    init(item: MovieDetails, delegate: WatchListMovieTableViewRowItemDelegate? = nil) {
        self.item = item
        self.delegate = delegate
    }
    
    func cellForItem(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WatchListTableCell.identifier, for: indexPath) as? WatchListTableCell else {
            return UITableViewCell()
        }
        cell.configure(with: item)
        cell.backgroundColor = .clear
        cell.delegate = self
        return cell
    }
}

extension WatchListMovieCellItem: WatchListTableCellDelegate{
    func watchListTableCellDidSelect(cell: WatchListTableCell) {
        delegate?.watchListMovieTableViewRowItemDelegate(cell: cell, rowItem: self)
    }
}
