//
//  MovieCastViewCell.swift
//  MoviesApp
//
//  Created by Asif Hussain on 09/08/2024.
//

import UIKit

protocol MovieCastViewCellDelegate: AnyObject {
    func movieCastViewCellDidSelect(cell: MovieCastViewCell)
}
class MovieCastViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCastViewCell"
    weak var delegate: MovieCastViewCellDelegate?
    
    let actorImageView: UIImageView = {
        let actorImageView = UIImageView()
        actorImageView.layer.cornerRadius = 50
        actorImageView.contentMode = .scaleAspectFill
        actorImageView.layer.masksToBounds = true
        actorImageView.translatesAutoresizingMaskIntoConstraints = false
        return actorImageView
    }()
    
    let actorNameLabel: UILabel = {
        let actorNameLabel = UILabel()
        actorNameLabel.textColor = .white
        actorNameLabel.font = AppFont.mediumPoppin12
        actorNameLabel.textAlignment = .center
        actorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return actorNameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureAction()
        
    }
    
    private func configureUI() {
        contentView.addSubview(actorImageView)
        contentView.addSubview(actorNameLabel)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            actorImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            actorImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            actorImageView.widthAnchor.constraint(equalToConstant: 100),
            actorImageView.heightAnchor.constraint(equalToConstant: 100),
            
            actorNameLabel.topAnchor.constraint(equalTo: actorImageView.bottomAnchor, constant: 8),
            actorNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            actorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    
    func configureAction() {
        isUserInteractionEnabled = true
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(contentViewTapped)))
    }
    
    @objc private func contentViewTapped() {
        delegate?.movieCastViewCellDidSelect(cell: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(with cast: Cast) {
        actorImageView.downloadImages(with: cast.profilePath ?? "")
        actorNameLabel.text = cast.originalName
    }
}
