//
//  WatchListTableCell.swift
//  MoviesApp
//
//  Created by Asif Hussain on 01/08/2024.
//

import UIKit

protocol WathcListTableCellDelegate: AnyObject{
    func watchListTableCellDidSelect(cell: WatchListTableCell)
}

class WatchListTableCell: UITableViewCell {
    static let identifier = "WatchListTableCell"
    weak var delegate: WathcListTableCellDelegate?
    
    var movieRatingView: MovieRatingView = {
        let movieRatingView = MovieRatingView()
        movieRatingView.backgroundColor = .clear
        movieRatingView.translatesAutoresizingMaskIntoConstraints = false
        return movieRatingView
    }()
    
    let contentViews: UIView = {
        let contentViews = UIView()
        contentViews.translatesAutoresizingMaskIntoConstraints = false
        return contentViews
    }()
    
    let movieGenreView = MovieGenreView()
    let movieYearView = MovieYearView()
    let movieDurationView = MovieTimeView()
    
    private let movieTitleLabel: UILabel = {
        let movieTitleLabel = UILabel()
        movieTitleLabel.font = AppFont.regularPoppin16
        movieTitleLabel.textColor = .white
        movieTitleLabel.numberOfLines = 1
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return movieTitleLabel
    }()
    
    private let moviePosterImage: UIImageView = {
        let moviePosterImage = UIImageView()
        moviePosterImage.layer.cornerRadius = 12
        moviePosterImage.layer.masksToBounds = true
        moviePosterImage.contentMode = .scaleAspectFill
        moviePosterImage.translatesAutoresizingMaskIntoConstraints = false
        return moviePosterImage
    }()
    let bgColorView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contentViews)
        contentViews.addSubview(moviePosterImage)
        contentViews.addSubview(movieTitleLabel)
        contentViews.addSubview(movieRatingView)
        contentViews.addSubview(movieGenreView)
        contentViews.addSubview(movieYearView)
        contentViews.addSubview(movieDurationView)
        contentView.backgroundColor = .clear
        bgColorView.backgroundColor = .clear
        self.selectedBackgroundView = bgColorView
        setupConstraints()
        isUserInteractionEnabled = true
        
        configureAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let bgColorView = UIView()
        bgColorView.backgroundColor =  .clear
        self.selectedBackgroundView = bgColorView
    }
    
    private func setupConstraints() {
        let contentViewHeightConstraint = contentViews.heightAnchor.constraint(equalToConstant: 120)
        contentViewHeightConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([
            contentViews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentViews.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            contentViewHeightConstraint,
            
            moviePosterImage.leadingAnchor.constraint(equalTo: contentViews.leadingAnchor, constant: 20),
            moviePosterImage.topAnchor.constraint(equalTo: contentViews.topAnchor),
            moviePosterImage.bottomAnchor.constraint(equalTo: contentViews.bottomAnchor),
            moviePosterImage.widthAnchor.constraint(equalToConstant: 95),
            
            movieTitleLabel.leadingAnchor.constraint(equalTo: moviePosterImage.trailingAnchor, constant: 10),
            movieTitleLabel.topAnchor.constraint(equalTo: contentViews.topAnchor, constant: 3),
            
            movieRatingView.leadingAnchor.constraint(equalTo: moviePosterImage.trailingAnchor),
            movieRatingView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 8),
            
            movieGenreView.leadingAnchor.constraint(equalTo: moviePosterImage.trailingAnchor, constant: 10),
            movieGenreView.topAnchor.constraint(equalTo: movieRatingView.bottomAnchor),
            
            movieYearView.leadingAnchor.constraint(equalTo: moviePosterImage.trailingAnchor, constant: 10),
            movieYearView.topAnchor.constraint(equalTo: movieGenreView.bottomAnchor, constant: 5),
            
            movieDurationView.leadingAnchor.constraint(equalTo: moviePosterImage.trailingAnchor, constant: 10),
            movieDurationView.topAnchor.constraint(equalTo: movieYearView.bottomAnchor, constant: 5),
        ])
    }
    
    func configure(with movie: MovieDetails) {
        let genreImage = movieGenreView.genreIcon.image?.withRenderingMode(.alwaysTemplate)
        let yearIcon = movieYearView.movieYearIcon.image?.withRenderingMode(.alwaysTemplate)
        let clockImage = movieDurationView.movieTimeIcon.image?.withRenderingMode(.alwaysTemplate)
        let x = movie.voteAverage
        let roundedX = Double(round(x * 10) / 10)
        moviePosterImage.downloadImages(with: movie.backdropPath)
        movieTitleLabel.text = movie.title
        movieRatingView.ratingLabel.text = String(roundedX)
        movieYearView.movieYearLabel.text = String(movie.releaseDate.prefix(4))
        movieDurationView.movieTimeLabel.text = String("\(movie.runtime) Minutes")
        movieGenreView.genreTypeLabel.text = movie.genres.first?.name
        
        //redesing views//
        movieGenreView.genreTypeLabel.textColor = .white
        movieGenreView.genreIcon.tintColor = .white
        movieGenreView.genreIcon.image = genreImage
        movieYearView.movieYearLabel.textColor = .white
        movieYearView.movieYearIcon.tintColor = .white
        movieYearView.movieYearIcon.image = yearIcon
        movieDurationView.movieTimeLabel.textColor = .white
        movieDurationView.movieTimeIcon.tintColor = .white
        movieDurationView.movieTimeIcon.image = clockImage
        
    }
    
    func configureAction() {
        isUserInteractionEnabled = true
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTapped)))
    }
    
    @objc private func cellTapped() {
        delegate?.watchListTableCellDidSelect(cell: self)
        print("TappedFromCell")
    }
}
