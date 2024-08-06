//
//  CategorizeMoviesSection.swift
//  MoviesApp
//
//  Created by Asif Hussain on 26/07/2024.
//

import UIKit

final class CategorizeMovieSection: CollectionViewSection {
    var headerTitle: String
    
    var items: [CollectionViewCellItem]
    init(headerTitle: String, items: [CollectionViewCellItem]) {
        self.items = items
        self.headerTitle = headerTitle
    }
    
    var layoutSection: NSCollectionLayoutSection {
        // Define the size of a single item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // Add horizontal spacing between items
           item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10) // Adjust the leading and trailing values for desired spacing
        // Define the size of the group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.28)) // Adjust height as needed
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Define the section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 20// Adjust spacing as needed
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 10)
        return section
    }
}
