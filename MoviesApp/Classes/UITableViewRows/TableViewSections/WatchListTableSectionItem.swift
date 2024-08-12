//
//  WatchListTableSectionItem.swift
//  MoviesApp
//
//  Created by Asif Hussain on 31/07/2024.
//

import Foundation
import UIKit

final class WatchListMovieSection: TableViewSection {
    var items: [TableViewCellItem]
    init(items: [TableViewCellItem]) {
        self.items = items
    }
}
