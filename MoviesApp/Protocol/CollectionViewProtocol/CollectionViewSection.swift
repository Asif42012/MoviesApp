//
//  CollectionViewSection.swift
//  MoviesApp
//
//  Created by Asif Hussain on 25/07/2024.
//

import Foundation
import UIKit

protocol CollectionViewSection {
    var headerTitle: String { set get }
    //for number of item in a single section
    var items: [CollectionViewCellItem] { set get }
    //layout of section
    var layoutSection: NSCollectionLayoutSection { get }
}

