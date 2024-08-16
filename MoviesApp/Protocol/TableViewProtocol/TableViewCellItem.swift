//
//  TableViewCellItem.swift
//  MoviesApp
//
//  Created by Asif Hussain on 13/08/2024.
//

import Foundation
import UIKit

protocol TableViewCellItem {
    func cellForItem(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell
}
