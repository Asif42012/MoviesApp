//
//  CategorizeMoviesectionCell.swift
//  MoviesApp
//
//  Created by Asif Hussain on 26/07/2024.
//

import UIKit

protocol CategorizeMovieSectionCellDelegate: AnyObject{
    func categorizeMovieCollectionViewCellDidSelect(cell: CategorizeMovieSectionCell)
}

class CategorizeMovieSectionCell: UICollectionViewCell {
    static let identifier = "CategorizeMoviesectionCell"
    weak var delegate: CategorizeMovieSectionCellDelegate?
    
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
        configureUI()
        configureAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstrains() {
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            posterImage.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configure(with movie: Movie) {
        posterImage.downloadImages(with: movie.posterPath)
    }
    
    private func configureUI(){
        contentView.addSubview(posterImage)
        setUpConstrains()
    }
    
    private func configureAction() {
        isUserInteractionEnabled = true
        posterImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(posterImageTapped)))
    }
    
    @objc private func posterImageTapped() {
        delegate?.categorizeMovieCollectionViewCellDidSelect(cell: self)
    }
}
