//
//  MovieReviewCellItem.swift
//  MoviesApp
//
//  Created by Asif Hussain on 02/08/2024.
//

import Foundation
import UIKit

final class MovieReviewCellItem: TableViewCellItem {
    let item: Review
  
    init(item: Review) {
        self.item = item
    }
    
    func cellForItem(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieReviewsView.identifier, for: indexPath) as? MovieReviewsView else {
            fatalError("Unsupported")
        }
        cell.configure(with: item)
        cell.backgroundColor = AppFont.tabBackgroundColor
        return cell
    }
}
