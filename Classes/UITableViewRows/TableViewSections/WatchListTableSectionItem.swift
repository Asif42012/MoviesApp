//
//  SaveMovies.swift
//  MoviesApp
//
//  Created by Asif Hussain on 31/07/2024.
//

//
//  SavedItemsMOHandler.swift
//  TMDB-sample-app
//
//  Created by Amol Dumrewal on 05/04/21.
//

import Foundation
import UIKit

final class WatchListMovieSection: TableViewSection {
    var items: [TableViewCellItem]
    init(items: [TableViewCellItem]) {
        self.items = items
    }
}
