//
//  MovieCategorySectionCellItem.swift
//  MoviesApp
//
//  Created by Asif Hussain on 02/08/2024.
//

import Foundation
import UIKit

protocol CategoryCollectionViewCellItemDelegate: AnyObject {
    func categoryCollectionViewCellItemDidSelect(cell: CategorySectionCell, cellItem: MovieCategorySectionCellItem)
}

final class MovieCategorySectionCellItem: CollectionViewCellItem {
    let item: MovieCategory
    var index: Int?
    weak var delegate: CategoryCollectionViewCellItemDelegate? = nil
    init(item: MovieCategory, delegate: CategoryCollectionViewCellItemDelegate? = nil){
        self.item = item
        self.delegate = delegate
    }
    func cellForItem(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorySectionCell.identifier, for: indexPath) as? CategorySectionCell else {
            fatalError("Unsupported")
        }
        cell.configure(with: item)
        cell.delegate = self
        return cell
    }
}

extension MovieCategorySectionCellItem: CategorySectionCellDelegate {
    func allMovieCollectionViewCellDidSelect(cell: CategorySectionCell) {
        delegate?.categoryCollectionViewCellItemDidSelect(cell: cell, cellItem: self)
    }
}

