//
//  MovieCoverImageView.swift
//  MoviesApp
//
//  Created by Asif Hussain on 09/08/2024.
//

import UIKit

protocol MovieCoverViewDelegate: AnyObject {
    func movieRatingTapped()
}

class MovieCoverView: UIView {
    
    weak var delegate: MovieCoverViewDelegate? = nil
    
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
    
    let movieRatingView: MovieRatingView = {
        let movieRatingView = MovieRatingView()
        movieRatingView.isUserInteractionEnabled = true
        movieRatingView.translatesAutoresizingMaskIntoConstraints = false
        return movieRatingView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configureUI()
        configureActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(backdropImage)
        addSubview(posterImage)
        addSubview(movieTitleLabel)
        addSubview(movieRatingView)
        
        setUpConstraints()
    }
    
    private func configureActions() {
        movieRatingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ratingTapped)))
    }
    
    @objc private func ratingTapped(){
        delegate?.movieRatingTapped()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            backdropImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            backdropImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backdropImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backdropImage.heightAnchor.constraint(equalToConstant: 211),
            
            movieRatingView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            movieRatingView.bottomAnchor.constraint(equalTo: backdropImage.bottomAnchor, constant: -10),
            
            posterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            posterImage.topAnchor.constraint(equalTo: backdropImage.bottomAnchor, constant: -70),
            posterImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: 120),
            posterImage.widthAnchor.constraint(equalToConstant: 95),
            
            movieTitleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10),
            movieTitleLabel.topAnchor.constraint(equalTo: backdropImage.bottomAnchor, constant: 10),
            movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
        ])
        backdropImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func configureView(with movieDetails: MovieDetails) {
        let x = movieDetails.voteAverage
        let roundedX = Double(round(x * 10) / 10)
        backdropImage.downloadImages(with: movieDetails.backdropPath)
        posterImage.downloadImages(with: movieDetails.posterPath)
        movieTitleLabel.text = movieDetails.title
        movieRatingView.ratingLabel.text = String(roundedX)
    }
}
