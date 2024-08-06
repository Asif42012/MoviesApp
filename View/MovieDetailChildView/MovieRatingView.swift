//
//  MovieRatingView.swift
//  MoviesApp
//
//  Created by Asif Hussain on 30/07/2024.
//

import UIKit

class MovieRatingView: UIView {
    
    let starIcon: UIImageView = {
       let starIcon = UIImageView(image: UIImage(named: "Ic_stars"))
        starIcon.contentMode = .scaleAspectFit
        starIcon.translatesAutoresizingMaskIntoConstraints = false
        return starIcon
    }()
    
    let ratingLabel: UILabel = {
       let ratingLabel = UILabel()
        ratingLabel.font = AppFont.medium12
        ratingLabel.textColor = UIColor(red: 255/255, green: 135/255, blue: 0, alpha: 1)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        return ratingLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        layer.masksToBounds = true
        backgroundColor = UIColor(red: 37/255, green: 40/255, blue: 54/255, alpha: 0.32)
        addSubview(starIcon)
        addSubview(ratingLabel)
        setUpConstraints()
        contentMode = .center
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            starIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            starIcon.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            starIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            ratingLabel.leadingAnchor.constraint(equalTo: starIcon.trailingAnchor, constant: 5),
            ratingLabel.topAnchor.constraint(equalTo: topAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            heightAnchor.constraint(equalToConstant: 24),
            widthAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
