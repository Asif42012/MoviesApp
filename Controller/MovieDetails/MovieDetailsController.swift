//
//  MovieDetailsController.swift
//  MoviesApp
//
//  Created by Asif Hussain on 24/07/2024.
//

import UIKit
import CoreData

class MovieDetailsController: BaseViewController {
    
    var coordinator: MainCoordinator?
    var viewModel: MovieDetailsViewViewModel?
    
    let sepratorView = SeparatorView()
    let sepratorView2 = SeparatorView()
    let movieYearView = MovieYearView()
    
    let movieDurationView = MovieTimeView()
    let movieGenreView = MovieGenreView()
    
    let movieRatingView: MovieRatingView = {
        let movieRatingView = MovieRatingView()
        movieRatingView.isUserInteractionEnabled = true
        movieRatingView.translatesAutoresizingMaskIntoConstraints = false
        return movieRatingView
    }()
    
    let stackedButtonView = ButtonsStackView()
    let aboutMovieView = AboutMovieView()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieReviewsView.self, forCellReuseIdentifier: MovieReviewsView.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Details"
        titleLabel.textColor = .white
        titleLabel.font = AppFont.regularPoppin16
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let backButton: UIButton = {
        let backButton = UIButton()
        if let image = UIImage(systemName: "arrow.left") {
            backButton.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        backButton.tintColor = .white
        backButton.contentMode = .center
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    let saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.setImage(UIImage(named: "Ic_bookMark"), for: .normal)
        saveButton.contentMode = .center
        if let image = UIImage(named: "Ic_bookMark") {
            saveButton.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        saveButton.tintColor = .white
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        return saveButton
    }()
    
    let backdropImage: UIImageView = {
        let backdropImage = UIImageView()
        backdropImage.layer.cornerRadius = 20
        backdropImage.layer.masksToBounds = true
        backdropImage.contentMode = .scaleAspectFill
        backdropImage.translatesAutoresizingMaskIntoConstraints = false
        return backdropImage
    }()
    
    let posterImage: UIImageView = {
        let posterImage = UIImageView()
        posterImage.layer.cornerRadius = 16
        posterImage.layer.masksToBounds = true
        posterImage.contentMode = .scaleAspectFill
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        return posterImage
    }()
    
    let movieTitleLabel: UILabel = {
        let movieTitleLabel = UILabel()
        movieTitleLabel.textColor = .white
        movieTitleLabel.numberOfLines = 2
        movieTitleLabel.font = AppFont.mediumPoppin18
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return movieTitleLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setUpActions()
        configureTableView()
        configureViewModel()
        fetchMovieDetails()
        loadWatchlistIds()
    }
    private func fetchMovieDetails() {
        Task{
            if let movieDetails = try await viewModel?.fetchMovieDetails() {
                updateUI(with: movieDetails)
            } else {
                // Handle the case where movie details are not available
                print("Failed to fetch movie details.")
            }
        }
    }
    func loadWatchlistIds() {
        viewModel?.loadWatchlistIds { result in
            switch result {
            case .success:
                print("Watchlist IDs loaded successfully")
            case .failure(let error):
                print("Failed to load watchlist IDs: \(error)")
            }
        }
    }
}

extension MovieDetailsController{
    
    private func configureUI(){
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(saveButton)
        view.addSubview(backdropImage)
        view.addSubview(posterImage)
        view.addSubview(movieTitleLabel)
        view.addSubview(movieYearView)
        view.addSubview(sepratorView)
        view.addSubview(sepratorView2)
        view.addSubview(movieDurationView)
        view.addSubview(movieGenreView)
        view.addSubview(movieRatingView)
        view.addSubview(stackedButtonView)
        view.addSubview(aboutMovieView)
        view.addSubview(tableView)
        tableView.isHidden = true
        view.backgroundColor = AppFont.tabBackgroundColor
        navigationController?.setNavigationBarHidden(true, animated: true)
        stackedButtonView.delegate = self
        setupConstrains()
    }
    
    private func configureViewModel() {
        viewModel?.fetchData()
        viewModel?.delegate = self
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - actions
    private func setUpActions() {
        backButton.addTarget(self, action: #selector(popViews), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveCurrentMovie), for: .touchUpInside)
        movieRatingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ratingTapped)))
    }
    
    @objc private func ratingTapped(){
        showRatingDialog()
    }
    
    @objc private func popViews() {
        coordinator?.popViewController()
    }
    
    @objc private func saveCurrentMovie() {
        viewModel?.saveCurrentMovieAsync { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    if success {
                        self.showAlertDialog(title: "Success", message: "Movie is Added to watchList", imageName: "checkmark.circle", imageTintColor: .green)
                    } else {
                        self.showAlertDialog(title: "Error", message: "Movie is already Added to watchList", imageName: "xmark.octagon", imageTintColor: .red)
                    }
                case .failure(let error):
                    print("Error saving movie: \(error)")
                }
            }
        }
    }
    
    //functio to show alert when movie is being added in a watchlist
    private func showAlertDialog(title: String, message: String, imageName: String, imageTintColor: UIColor) {
        let alertDialogue = AlertsDialouge()
        alertDialogue.configureAlert(title: title, message: message, imageName: imageName, imageTintColor: imageTintColor)
        alertDialogue.modalPresentationStyle = .overFullScreen
        alertDialogue.modalTransitionStyle = .crossDissolve
        present(alertDialogue, animated: true, completion: nil)
    }
    
    //show rating dialoge when user rate the movie
    private func showRatingDialog() {
        let ratingDialogue = MovieRatingControllerViewController()
        ratingDialogue.delegate = self
        ratingDialogue.modalPresentationStyle = .overFullScreen
        ratingDialogue.modalTransitionStyle = .crossDissolve
        present(ratingDialogue, animated: true, completion: nil)
    }
}

// MARK: - configure Data
extension MovieDetailsController{
    private func updateUI(with movieDetails: MovieDetails) {
        DispatchQueue.main.async { [self] in
            let x = movieDetails.voteAverage
            let roundedX = Double(round(x * 10) / 10)
            backdropImage.downloadImages(with: movieDetails.backdropPath)
            posterImage.downloadImages(with: movieDetails.posterPath)
            movieTitleLabel.text = movieDetails.title
            movieYearView.movieYearLabel.text = String(movieDetails.releaseDate.prefix(4))
            movieDurationView.movieTimeLabel.text = "\(movieDetails.runtime) Minutes"
            movieGenreView.genreTypeLabel.text = movieDetails.genres.first?.name
            movieRatingView.ratingLabel.text = String(roundedX)
            aboutMovieView.aboutMovieLabel.text = movieDetails.overview
        }
    }
}
// MARK: - View constrains
extension MovieDetailsController{
    private func setupConstrains(){
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            saveButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.024),
            
            backdropImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            backdropImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backdropImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backdropImage.heightAnchor.constraint(equalToConstant: 211),
            
            movieRatingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            movieRatingView.bottomAnchor.constraint(equalTo: backdropImage.bottomAnchor, constant: -10),
            
            posterImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            posterImage.bottomAnchor.constraint(equalTo:  backdropImage.bottomAnchor, constant: 70),
            posterImage.heightAnchor.constraint(equalToConstant: 120),
            posterImage.widthAnchor.constraint(equalToConstant: 95),
            
            movieTitleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10),
            movieTitleLabel.topAnchor.constraint(equalTo: backdropImage.bottomAnchor, constant: 10),
            movieTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            sepratorView.trailingAnchor.constraint(equalTo: movieDurationView.leadingAnchor, constant: -10),
            sepratorView.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 15),
            sepratorView.heightAnchor.constraint(equalToConstant: 16),
            sepratorView.widthAnchor.constraint(equalToConstant: 1),
            
            movieDurationView.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 15),
            movieDurationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            movieYearView.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 15),
            movieYearView.trailingAnchor.constraint(equalTo: sepratorView.leadingAnchor, constant: -10),
            
            sepratorView2.leadingAnchor.constraint(equalTo: movieDurationView.trailingAnchor, constant: 10),
            sepratorView2.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 15),
            sepratorView2.heightAnchor.constraint(equalToConstant: 16),
            sepratorView2.widthAnchor.constraint(equalToConstant: 1),
            
            movieGenreView.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 15),
            movieGenreView.leadingAnchor.constraint(equalTo: sepratorView2.trailingAnchor, constant: 10),
            
            stackedButtonView.topAnchor.constraint(equalTo: movieDurationView.bottomAnchor, constant: 20),
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        backdropImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}

extension MovieDetailsController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MovieDetailsController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < (viewModel?.tableSections.count ?? 0) else {
            return 0
        }
        return viewModel?.tableSections[section].items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = viewModel?.tableSections[indexPath.section], indexPath.row < section.items.count else {
            print("Item index out of range at section \(indexPath.section), row \(indexPath.row)")
            return UITableViewCell()
        }
        let item = section.items[indexPath.row]
        return item.cellForItem(at: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MovieDetailsController: MovieDetailsViewViewModelDelegate{
    func movieDetailsViewViewModelReloadData() {
        tableView.reloadData()
    }
}

extension MovieDetailsController: ButtonsStackViewDelegate{
    func didTapAboutButton() {
        aboutMovieView.isHidden = false
        tableView.isHidden = true
    }
    
    func didTapReviewButton() {
        aboutMovieView.isHidden = true
        tableView.isHidden = false
    }
    
    func didTapCastButton() {
        aboutMovieView.isHidden = true
        tableView.isHidden = true
    }
}

extension MovieDetailsController: MovieRatingControllerDelegate{
    func didSubmitRating(_ rating: Double) {
        print("This is submitted rating \(rating)")
        viewModel?.rateMovie(rating: rating, completion: { result in
            switch result {
            case .success(let success):
                print("Rating submitted successfully: \(success)")
            case .failure(let error):
                print("Failed to submit rating: \(error)")
            }
        })
    }
}
