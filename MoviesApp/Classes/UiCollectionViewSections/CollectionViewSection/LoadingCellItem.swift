//
//  LoadingCellItem.swift
//  MoviesApp
//
//  Created by Asif Hussain on 29/07/2024.
//

import Foundation
import UIKit

final class LoadingCellItem: CollectionViewCellItem {
    func cellForItem(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingIndicatorCell.identifier, for: indexPath) as! LoadingIndicatorCell
        cell.activityIndicator.startAnimating()
        return cell
    }
}
