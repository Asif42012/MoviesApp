//
//  MovieHomeCollectionViewManager.swift
//  MoviesApp
//
//  Created by Asif Hussain on 14/08/2024.
//

import Foundation
import UIKit

protocol MovieHomeViewDataSource: AnyObject {
    var sections: [CollectionViewSection] { get }
}

class MovieHomeCollectionViewManager: NSObject {
    private let collectionView: UICollectionView
    private weak var dataSource: MovieHomeViewDataSource?
    
    init(dataSource: MovieHomeViewDataSource) {
        self.dataSource = dataSource
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: MovieHomeCollectionViewManager.getCollectionViewLayout(with: dataSource))
        super.init()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = AppFont.tabBackgroundColor
        collectionView.showsVerticalScrollIndicator = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCells()
    }
    
    private func registerCells() {
        collectionView.register(SearchSectionCell.self, forCellWithReuseIdentifier: SearchSectionCell.identifier)
        collectionView.register(AllMoviesSectionCell.self, forCellWithReuseIdentifier: AllMoviesSectionCell.identifier)
        collectionView.register(CategorySectionCell.self, forCellWithReuseIdentifier: CategorySectionCell.identifier)
        collectionView.register(CategorizeMovieSectionCell.self, forCellWithReuseIdentifier: CategorizeMovieSectionCell.identifier)
        collectionView.register(LoadingIndicatorCell.self, forCellWithReuseIdentifier: LoadingIndicatorCell.identifier)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func attachCollectionView(to view: UIView) {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    static func getCollectionViewLayout(with dataSource: MovieHomeViewDataSource) -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            dataSource.sections[sectionIndex].layoutSection
        }
    }
}

extension MovieHomeCollectionViewManager: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.sections.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.sections[section].items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = dataSource?.sections[indexPath.section] else {
            return UICollectionViewCell()
        }
        
        if section.items[indexPath.item] is LoadingCellItem {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingIndicatorCell.identifier, for: indexPath) as! LoadingIndicatorCell
            cell.activityIndicator.startAnimating()
            return cell
        } else {
            return section.items[indexPath.item].cellForItem(at: indexPath, in: collectionView)
        }
    }
}

extension MovieHomeCollectionViewManager: UICollectionViewDelegate {
    
}
