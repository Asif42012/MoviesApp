//
//  MovieGenreView.swift
//  MoviesApp
//
//  Created by Asif Hussain on 30/07/2024.
//

import UIKit

class MovieGenreView: UIView {
    
    let genreIcon: UIImageView = {
        let genreIcon = UIImageView()
        genreIcon.image = UIImage(named: "Ic_gener")
        genreIcon.translatesAutoresizingMaskIntoConstraints = false
        return genreIcon
    }()
    
    let genreTypeLabel: UILabel = {
        let genreTypeLabel = UILabel()
        genreTypeLabel.font = AppFont.medium12
        genreTypeLabel.textColor = UIColor(red: 146/255, green: 146/255, blue: 157/255, alpha: 1)
        genreTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        return genreTypeLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private func configureUI(){
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(genreIcon)
        addSubview(genreTypeLabel)
        setUpContraints()
    }
    
    private func setUpContraints() {
        NSLayoutConstraint.activate([
            genreIcon.leadingAnchor.constraint(equalTo: leadingAnchor),
            genreIcon.topAnchor.constraint(equalTo: topAnchor),
            genreIcon.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            genreTypeLabel.topAnchor.constraint(equalTo: topAnchor),
            genreTypeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            genreTypeLabel.leadingAnchor.constraint(equalTo: genreIcon.trailingAnchor, constant: 5),
            genreTypeLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightAnchor.constraint(equalToConstant: 16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
