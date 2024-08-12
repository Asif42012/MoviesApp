//
//  MovieDetailsController.swift
//  MoviesApp
//
//  Created by Asif Hussain on 24/07/2024.
//

import UIKit

class MovieDetailsController: BaseViewController {
    
    var coordinator: MainCoordinator?
    private let viewModel: MovieDetailsViewViewModel
    
    init(viewModel: MovieDetailsViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let stackedButtonView = ButtonsStackView()
    let aboutMovieView = AboutMovieView()
    let movieCoverView = MovieCoverView()
    
    let movieInfo = MovieInfoView()
    let tableView = MovieReviewTableView()
    let collectionView = MovieCastCollectionView()
    let headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewModel()
        fetchMovieDetails()
        loadWatchlistIds()
    }
}

extension MovieDetailsController{
    
    private func configureUI(){
        view.addSubview(headerView)
        view.addSubview(movieCoverView)
        view.addSubview(movieInfo)
        view.addSubview(stackedButtonView)
        view.addSubview(aboutMovieView)
        view.addSubview(tableView)
        view.addSubview(collectionView)
        tableView.isHidden = true
        collectionView.isHidden = true
        view.backgroundColor = AppFont.tabBackgroundColor
        navigationController?.setNavigationBarHidden(true, animated: true)
        stackedButtonView.delegate = self
        headerView.delegate = self
        movieCoverView.delegate = self
        setupConstrains()
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            movieCoverView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            movieCoverView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieCoverView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            movieInfo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieInfo.topAnchor.constraint(equalTo: movieCoverView.bottomAnchor),
            
            stackedButtonView.topAnchor.constraint(equalTo: movieInfo.bottomAnchor, constant: 20),
            stackedButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            stackedButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            stackedButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            aboutMovieView.topAnchor.constraint(equalTo: stackedButtonView.bottomAnchor, constant: 20),
            aboutMovieView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            aboutMovieView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            aboutMovieView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: stackedButtonView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: stackedButtonView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureViewModel() {
        viewModel.fetchData()
        viewModel.delegate = self
    }
    
    private func configureCustomView() {
        tableView.setSections(viewModel.tableSections)
        collectionView.setSections(viewModel.collectionViewSections)
    }
    
    private func fetchMovieDetails() {
        Task {
            do {
                let movieDetails = try await viewModel.fetchMovieDetails()
                updateUI(with: movieDetails)
            } catch {
                print("Failed to fetch movie details: \(error)")
            }
        }
    }
    
    
    private func loadWatchlistIds() {
        viewModel.loadWatchlistIds { result in
            switch result {
            case .success:
                print("Watchlist IDs loaded successfully")
            case .failure(let error):
                print("Failed to load watchlist IDs: \(error)")
            }
        }
    }
    
    private func showAlertDialog(title: String, message: String, imageName: String, imageTintColor: UIColor) {
        let alertDialogue = AlertsDialogue()
        alertDialogue.configureAlert(title: title, message: message, imageName: imageName, imageTintColor: imageTintColor)
        alertDialogue.modalPresentationStyle = .overFullScreen
        alertDialogue.modalTransitionStyle = .crossDissolve
        present(alertDialogue, animated: true, completion: nil)
    }
    
    private func showRatingDialog() {
        let ratingDialogue = MovieRatingAlert()
        ratingDialogue.delegate = self
        ratingDialogue.modalPresentationStyle = .overFullScreen
        ratingDialogue.modalTransitionStyle = .crossDissolve
        present(ratingDialogue, animated: true, completion: nil)
    }
    
    private func updateUI(with movieDetails: MovieDetails) {
        DispatchQueue.main.async { [self] in
            movieInfo.configureView(with: movieDetails)
            movieCoverView.configureView(with: movieDetails)
            aboutMovieView.aboutMovieLabel.text = movieDetails.overview
        }
    }
}

extension MovieDetailsController: MovieDetailsViewViewModelDelegate {
    func movieDetailsViewViewModelReloadData() {
        configureCustomView()
    }
}

extension MovieDetailsController: HeaderViewButtonDidTapDelegate {
    func backButtonDidTap() {
        coordinator?.popViewController()
    }
    
    func saveButtonDidTap() {
        Task { @MainActor in
            do {
                let result = await viewModel.saveCurrentMovieAsync()
                
                switch result {
                case .success(let success):
                    if success {
                        showAlertDialog(title: "Success", message: "Movie is Added to watchList",
                                        imageName: "checkmark.circle", imageTintColor: .green)
                    } else {
                        showAlertDialog(title: "Error", message: "Movie is already Added to watchList",
                                        imageName: "xmark.octagon", imageTintColor: .red)
                    }
                case .failure(let error):
                    print("Error saving movie: \(error)")
                    showAlertDialog(title: "Error", message: "Failed to save movie: \(error.localizedDescription)",
                                    imageName: "xmark.octagon", imageTintColor: .red)
                }
            } catch {
                print("Unexpected error: \(error)")
                showAlertDialog(title: "Error", message: "Unexpected error occurred: \(error.localizedDescription)",
                                imageName: "xmark.octagon", imageTintColor: .red)
            }
        }
    }
}

extension MovieDetailsController: MovieCoverViewDelegate {
    func movieRatingTapped() {
        showRatingDialog()
    }
}

extension MovieDetailsController: MovieRatingControllerDelegate {
    func didSubmitRating(_ rating: Double) {
        
        Task { @MainActor in
            do {
                let success = try await viewModel.rateMovie(rating: rating)
                print("Rating submitted successfully: \(success)")
            } catch {
                print("Failed to submit rating: \(error)")
                showAlertDialog(title: "Error", message: "Failed to submit rating: \(error.localizedDescription)",
                                imageName: "xmark.octagon", imageTintColor: .red)
            }
        }
    }
}

extension MovieDetailsController: ButtonsStackViewDelegate {
    func didTapAboutButton() {
        aboutMovieView.isHidden = false
        tableView.isHidden = true
        collectionView.isHidden = true
    }
    
    func didTapReviewButton() {
        aboutMovieView.isHidden = true
        tableView.isHidden = false
        tableView.tableView.isHidden = false
        collectionView.isHidden = true
    }
    
    func didTapCastButton() {
        aboutMovieView.isHidden = true
        tableView.isHidden = true
        collectionView.isHidden = false
        collectionView.collectionView.isHidden = false
    }
}
