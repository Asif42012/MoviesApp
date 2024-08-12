//
//  AllMovieSectionCellItem.swift
//  MoviesApp
//
//  Created by Asif Hussain on 02/08/2024.
//

import Foundation
import UIKit

protocol AllMovieCollectionViewCellItemDelegate: AnyObject {
    func allMovieCollectionViewCellItemDidSelect(cell: AllMoviesSectionCell, cellItem: AllMoviesCellItem)
}

final class AllMoviesCellItem: CollectionViewCellItem {
    let item: Movie
    weak var delegate: AllMovieCollectionViewCellItemDelegate? = nil
    
    init(item: Movie, delegate:  AllMovieCollectionViewCellItemDelegate? = nil){
        self.item = item
        self.delegate = delegate
    }
    
    func cellForItem(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllMoviesSectionCell.identifier, for: indexPath) as? AllMoviesSectionCell else {
            fatalError("Unsupported")
        }
        let indexNumber = indexPath.item + 1
        cell.configure(with: item, indexNumber: indexNumber)
        cell.delegate = self
        return cell
    }
    
}

extension AllMoviesCellItem: AllMoviesSectionCellDelegate {
    func allMovieCollectionViewCellDidSelect(cell: AllMoviesSectionCell) {
        delegate?.allMovieCollectionViewCellItemDidSelect(cell: cell, cellItem: self)
    }
}
