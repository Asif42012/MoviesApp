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
            posterImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: 220),
        ])
    }
    
    func configure(with movie: Movie) {
        posterImage.downloadImages(with: movie.posterPath)
    }
    
    private func configureUi(){
        contentView.addSubview(posterImage)
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
