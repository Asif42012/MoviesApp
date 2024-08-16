//
//  CollectionViewFlowCellItem.swift
//  MoviesApp
//
//  Created by Asif Hussain on 25/07/2024.
//

import Foundation
import UIKit

protocol CollectionViewFlowCellItem {
    func cellForItem(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell
}
