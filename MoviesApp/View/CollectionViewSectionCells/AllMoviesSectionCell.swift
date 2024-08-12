//
//  AllMoviesSectionCell.swift
//  MoviesApp
//
//  Created by Asif Hussain on 25/07/2024.
//

import UIKit

protocol AllMoviesSectionCellDelegate: AnyObject {
    func allMovieCollectionViewCellDidSelect(cell: AllMoviesSectionCell)
}

class AllMoviesSectionCell: UICollectionViewCell {
    
    static let identifier = "AllMoviesSectionCell"
    weak var delegate: AllMoviesSectionCellDelegate?
    
    let posterImage: UIImageView = {
        let posterImage = UIImageView()
        posterImage.contentMode = .scaleAspectFill
        posterImage.layer.cornerRadius = 10
        posterImage.layer.masksToBounds = true
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.isUserInteractionEnabled = true
        return posterImage
    }()
    
    let movieIndexLabel: UILabel = {
        let movieIndexLabel = UILabel()
        movieIndexLabel.font = AppFont.bold96
        movieIndexLabel.textColor = UIColor(red: 36/255, green: 42/255, blue: 50/255, alpha: 1)
        movieIndexLabel.translatesAutoresizingMaskIntoConstraints = false
        let text = "1"
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor(red: 2/255, green: 150/255, blue: 229/255, alpha: 1),
            .foregroundColor: UIColor(red: 36/255, green: 42/255, blue: 50/255, alpha: 1),
            .strokeWidth: -1.0,
        ]
        let attributedString = NSAttributedString(string: text, attributes: strokeTextAttributes)
        movieIndexLabel.attributedText = attributedString
        return movieIndexLabel
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUi()
        configureAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstrains() {
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            posterImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: 220),
            
            movieIndexLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieIndexLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40),
        ])
    }
    
    func configure(with movie: Movie, indexNumber: Int) {
        posterImage.downloadImages(with: movie.posterPath)
        movieIndexLabel.text = String(indexNumber)
    }
    
    private func configureUi(){
        contentView.addSubview(posterImage)
        contentView.addSubview(movieIndexLabel)
        setUpConstrains()
    }
    
    func configureAction() {
        isUserInteractionEnabled = true
        posterImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(posterImageViewTapped)))
    }
    
    @objc private func posterImageViewTapped() {
        delegate?.allMovieCollectionViewCellDidSelect(cell: self)
    }
}
