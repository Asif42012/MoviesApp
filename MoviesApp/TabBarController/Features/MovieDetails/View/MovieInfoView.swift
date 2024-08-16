//
//  MovieInfoView.swift
//  MoviesApp
//
//  Created by Asif Hussain on 09/08/2024.
//

import UIKit

class MovieInfoView: UIView {
    
    let separatorView = SeparatorView()
    let separatorView2 = SeparatorView()
    let movieYearView = MovieYearView()
    let movieDurationView = MovieTimeView()
    let movieGenreView = MovieGenreView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configureUI()
    }
    
    private func configureUI() {
        addSubview(movieYearView)
        addSubview(separatorView)
        addSubview(separatorView2)
        addSubview(movieDurationView)
        addSubview(movieGenreView)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            separatorView.trailingAnchor.constraint(equalTo: movieDurationView.leadingAnchor, constant: -10),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            separatorView.heightAnchor.constraint(equalToConstant: 16),
            separatorView.widthAnchor.constraint(equalToConstant: 1),
            
            movieDurationView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            movieDurationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            movieYearView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            movieYearView.trailingAnchor.constraint(equalTo: separatorView.leadingAnchor, constant: -10),
            
            separatorView2.leadingAnchor.constraint(equalTo: movieDurationView.trailingAnchor, constant: 10),
            separatorView2.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            separatorView2.heightAnchor.constraint(equalToConstant: 16),
            separatorView2.widthAnchor.constraint(equalToConstant: 1),
            
            movieGenreView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            movieGenreView.leadingAnchor.constraint(equalTo: separatorView2.trailingAnchor, constant: 10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(with movieDetails: MovieDetails) {
        movieYearView.movieYearLabel.text = String(movieDetails.releaseDate.prefix(4))
        movieDurationView.movieTimeLabel.text = "\(movieDetails.runtime) Minutes"
        movieGenreView.genreTypeLabel.text = movieDetails.genres.first?.name
    }
}
