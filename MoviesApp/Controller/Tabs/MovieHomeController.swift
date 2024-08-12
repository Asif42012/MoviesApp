//
//  ViewController.swift
//  MoviesApp
//
//  Created by Asif Hussain on 24/07/2024.
//

import UIKit

class MovieHomeController: BaseViewController {
    var coordinator: MainCoordinator?
    private let viewModel: MovieHomeControllerViewModel
    
    init(viewModel: MovieHomeControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: getCollectionViewLayout())
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = AppFont.tabBackgroundColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
        configureViewModel()
    }
}

extension MovieHomeController {
    
    private func getCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            self.viewModel.sections[sectionIndex].layoutSection
        }
    }
    
    private func configureUI() {
        view.backgroundColor = AppFont.tabBackgroundColor
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(SearchSectionCell.self, forCellWithReuseIdentifier: SearchSectionCell.identifier)
        collectionView.register(AllMoviesSectionCell.self, forCellWithReuseIdentifier: AllMoviesSectionCell.identifier)
        collectionView.register(CategorySectionCell.self, forCellWithReuseIdentifier: CategorySectionCell.identifier)
        collectionView.register(CategorizeMovieSectionCell.self, forCellWithReuseIdentifier: CategorizeMovieSectionCell.identifier)
        collectionView.register(LoadingIndicatorCell.self, forCellWithReuseIdentifier: LoadingIndicatorCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: collectionView.topAnchor),
            view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
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

// MARK: - UICollectionViewDelegate
extension MovieHomeController: UICollectionViewDelegate{
}

// MARK: - UICollectionViewDataSource
extension MovieHomeController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.sections[indexPath.section]
        if section.items[indexPath.item] is LoadingCellItem {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingIndicatorCell.identifier, for: indexPath) as! LoadingIndicatorCell
            cell.activityIndicator.startAnimating()
            return cell
        } else {
            return section.items[indexPath.item].cellForItem(at: indexPath, in: collectionView)
        }
    }
}

extension MovieHomeController: MovieHomeControllerViewModelDelegate {
    func movieHomeControllerViewModelReloadData() {
        self.collectionView.reloadData()
    }
}

extension MovieHomeController: AllMovieCollectionViewCellItemDelegate {
    func allMovieCollectionViewCellItemDidSelect(cell: AllMoviesSectionCell, cellItem: AllMoviesCellItem) {
        coordinator?.showMovieDetails(cellItem.item)
    }
}

extension MovieHomeController: CategorizeMoviesCollectionViewCellItemDelegate {
    func categorizeMoviesCollectionViewCellItemDidSelect(cell: CategorizeMovieSectionCell, cellItem: CategorizeMovieCellItem) {
        coordinator?.showMovieDetails(cellItem.item)
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
        print("SearchDelegateCalled")
        coordinator?.showSearchTabAndActivateSearchBar()
    }
}
