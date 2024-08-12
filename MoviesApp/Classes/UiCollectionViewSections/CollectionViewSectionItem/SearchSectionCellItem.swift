//
//  SearchSectionCellItem.swift
//  MoviesApp
//
//  Created by Asif Hussain on 02/08/2024.
//

import Foundation
import UIKit

protocol SearchCollectionViewCellItemDelegate: AnyObject{
    func searchCollectionViewCellItemDidSelect(cell: SearchSectionCell, cellItem: SearchCellItem)
}

final class SearchCellItem: CollectionViewCellItem {
    let item: String
    weak var delegate: SearchCollectionViewCellItemDelegate? = nil
    init(item: String, delegate: SearchCollectionViewCellItemDelegate? = nil){
        self.item = item
        self.delegate = delegate
    }
    
    func cellForItem(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchSectionCell.identifier, for: indexPath) as? SearchSectionCell else {
            fatalError("Unsupported")
        }
        cell.configure(with: item)
        cell.delegate = self
        return cell
    }
}

extension SearchCellItem: SearchSectionCellDelegate{
    func searchCollectionViewCellDidSelect(cell: SearchSectionCell) {
        delegate?.searchCollectionViewCellItemDidSelect(cell: cell, cellItem: self)
    }
}
