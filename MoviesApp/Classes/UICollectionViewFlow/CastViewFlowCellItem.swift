//
//  CastViewCellItem.swift
//  MoviesApp
//
//  Created by Asif Hussain on 09/08/2024.
//

import Foundation
import UIKit

protocol MovieCastCollectionViewCellItemDelegate: AnyObject {
    func movieCastCollectionViewCellItemDidSelect(cell: MovieCastViewCell, cellItem: CastViewCellItem)
}

final class CastViewCellItem: CollectionViewFlowCellItem {
    let item: Cast
    weak var delegate: MovieCastCollectionViewCellItemDelegate? = nil
    
    init(item: Cast, delegate: MovieCastCollectionViewCellItemDelegate? = nil){
        self.item = item
        self.delegate = delegate
    }
    
    func cellForItem(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCastViewCell.identifier, for: indexPath) as? MovieCastViewCell else {
            fatalError("Unsupported")
        }
        cell.configureView(with: item)
        cell.delegate = self
        return cell
    }
}

extension CastViewCellItem: MovieCastViewCellDelegate{
    func movieCastViewCellDidSelect(cell: MovieCastViewCell) {
        delegate?.movieCastCollectionViewCellItemDidSelect(cell: cell, cellItem: self)
    }
}
