//
//  CollectionViewCellItem.swift
//  MoviesApp
//
//  Created by Asif Hussain on 25/07/2024.
//

import Foundation
import UIKit
//cell item for collection view
protocol CollectionViewCellItem {
    func cellForItem(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell
}
//cell item for table view 
protocol TableViewCellItem {
    func cellForItem(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell
}
