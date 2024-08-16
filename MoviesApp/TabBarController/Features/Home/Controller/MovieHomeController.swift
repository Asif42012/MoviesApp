//
//  ViewController.swift
//  MoviesApp
//
//  Created by Asif Hussain on 24/07/2024.
//

import UIKit

class MovieHomeController: BaseViewController {
    private let coordinator: MainCoordinator
    private let viewModel: MovieHomeControllerViewModel
    private var collectionViewManager: MovieHomeCollectionViewManager?
    
    init(coordinator: MainCoordinator, viewModel: MovieHomeControllerViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewModel()
    }
}

private extension MovieHomeController {
    
    private func configureUI() {
        view.backgroundColor = AppFont.tabBackgroundColor
        setupCollectionViewManager()
    }
    
    private func setupCollectionViewManager() {
        collectionViewManager = MovieHomeCollectionViewManager(dataSource: viewModel)
        collectionViewManager?.attachCollectionView(to: view)
    }
    
    private func configureViewModel() {
        viewModel.fetchData()
        viewModel.delegate = self
        viewModel.allMovieDelegate = self
        viewModel.allCategorizeMovieDelegate = self
        viewModel.allCategoryButtonsDelegate = self
        viewModel.searchBarDelegate = self
    }
}

extension MovieHomeController: MovieHomeViewDelegate {
    func movieHomeViewReloadData() {
        collectionViewManager?.reloadData()
    }
}

extension MovieHomeController: AllMovieCollectionViewCellItemDelegate {
    func allMovieCollectionViewCellItemDidSelect(cell: AllMoviesSectionCell, cellItem: AllMoviesCellItem) {
        coordinator.showMovieDetails(cellItem.item)
    }
}

extension MovieHomeController: CategorizeMoviesCollectionViewCellItemDelegate {
    func categorizeMoviesCollectionViewCellItemDidSelect(cell: CategorizeMovieSectionCell, cellItem: CategorizeMovieCellItem) {
        coordinator.showMovieDetails(cellItem.item)
    }
}

extension MovieHomeController: CategoryCollectionViewCellItemDelegate {
    func categoryCollectionViewCellItemDidSelect(cell: CategorySectionCell, cellItem: MovieCategorySectionCellItem) {
        let itemName = cellItem.item.categoryName
        viewModel.fetchMoviesWithCategories(for: itemName)
    }
}

extension MovieHomeController: SearchCollectionViewCellItemDelegate{
    func searchCollectionViewCellItemDidSelect(cell: SearchSectionCell, cellItem: SearchCellItem) {
        coordinator.showSearchTabAndActivateSearchBar()
    }
}
