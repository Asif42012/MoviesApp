//
//  CastViewFlow.swift
//  MoviesApp
//
//  Created by Asif Hussain on 09/08/2024.
//

import Foundation

final class CastViewFlow: CollectionViewFlowSection {
    var items: [CollectionViewFlowCellItem]
    init(items: [CollectionViewFlowCellItem]){
        self.items = items
    }
}
