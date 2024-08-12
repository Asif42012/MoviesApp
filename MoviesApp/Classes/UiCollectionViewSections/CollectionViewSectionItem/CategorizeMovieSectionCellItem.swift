//
//  CategorizeMovieSectionCellItem.swift
//  MoviesApp
//
//  Created by Asif Hussain on 02/08/2024.
//

import Foundation
import UIKit

protocol CategorizeMoviesCollectionViewCellItemDelegate: AnyObject {
    func categorizeMoviesCollectionViewCellItemDidSelect(cell: CategorizeMovieSectionCell, cellItem: CategorizeMovieCellItem)
}

final class CategorizeMovieCellItem: CollectionViewCellItem {
    let item: Movie
    weak var delegate: CategorizeMoviesCollectionViewCellItemDelegate? = nil
    init(item: Movie, delegate: CategorizeMoviesCollectionViewCellItemDelegate? = nil){
        self.item = item
        self.delegate = delegate
    }
    func cellForItem(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorizeMovieSectionCell.identifier, for: indexPath) as? CategorizeMovieSectionCell else {
            fatalError("Unsupported")
        }
        cell.configure(with: item)
        cell.delegate = self
        return cell
    }
}

extension CategorizeMovieCellItem: CategorizeMovieSectionCellDelegate{
    func categorizeMovieCollectionViewCellDidSelect(cell: CategorizeMovieSectionCell){
        delegate?.categorizeMoviesCollectionViewCellItemDidSelect(cell: cell, cellItem: self)
    }
}
