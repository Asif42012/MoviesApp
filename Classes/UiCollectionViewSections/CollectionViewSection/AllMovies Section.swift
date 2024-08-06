//
//  AllMovies Section.swift
//  MoviesApp
//
//  Created by Asif Hussain on 25/07/2024.
//

import Foundation
import UIKit

final class AllMoviesSection: CollectionViewSection {
    var headerTitle: String
    
    var items: [CollectionViewCellItem]
    init(headerTitle: String, items: [CollectionViewCellItem]) {
        self.items = items
        self.headerTitle = headerTitle
    }
    
    var layoutSection: NSCollectionLayoutSection {
        // Define the item size for the category buttons
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(165),
                                              heightDimension: .absolute(230))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // Define the group size for the horizontal scrollable category buttons
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(700),
                                               heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        // Define the section and its boundary supplementary items
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 25
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 15, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}
