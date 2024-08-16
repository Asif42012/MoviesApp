//
//  CollectionViewCellItemProtocol.swift
//  MoviesApp
//
//  Created by Asif Hussain on 13/08/2024.
//

import Foundation
import UIKit

protocol CollectionViewCellItem {
    func cellForItem(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell
}
