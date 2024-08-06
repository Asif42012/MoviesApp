//
//  CenterCotentView.swift
//  MoviesApp
//
//  Created by Asif Hussain on 30/07/2024.
//

import UIKit

class CenterCotentView: UIView {
    
    let emptyBoxImage: UIImageView = {
       let emptyBoxImage = UIImageView(image: UIImage(named: "Ic_box"))
        emptyBoxImage.contentMode = .scaleAspectFit
        emptyBoxImage.translatesAutoresizingMaskIntoConstraints = false
        return emptyBoxImage
    }()
    
    let noMovieLabel: UILabel = {
       let noMovieLabel = UILabel()
        noMovieLabel.text = "There is No Movie Yet!"
        noMovieLabel.font = AppFont.regularPoppin16
        noMovieLabel.textColor = .white
        noMovieLabel.textAlignment = .center
        noMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        return noMovieLabel
    }()
    
    let noMovieDescriptionLabel: UILabel = {
       let noMovieDescriptionLabel = UILabel()
        noMovieDescriptionLabel.font = AppFont.medium12
        noMovieDescriptionLabel.textColor = UIColor(red: 146/255, green: 146/255, blue: 157/255, alpha: 1)
        noMovieDescriptionLabel.numberOfLines = 2
        noMovieDescriptionLabel.textAlignment = .center
        noMovieDescriptionLabel.text = "Find your movie by Type title,\ncategories, years, etc "
        noMovieDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return noMovieDescriptionLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(emptyBoxImage)
        addSubview(noMovieLabel)
        addSubview(noMovieDescriptionLabel)
        setUpConstrains()
    }
    
    private func setUpConstrains() {
        NSLayoutConstraint.activate([
            emptyBoxImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyBoxImage.topAnchor.constraint(equalTo: topAnchor),
            emptyBoxImage.heightAnchor.constraint(equalToConstant: 76),
            emptyBoxImage.widthAnchor.constraint(equalToConstant: 76),
            
            noMovieLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            noMovieLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            noMovieLabel.topAnchor.constraint(equalTo: emptyBoxImage.bottomAnchor, constant: 20),
            noMovieDescriptionLabel.topAnchor.constraint(equalTo: noMovieLabel.bottomAnchor, constant: 10),
            noMovieDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            noMovieDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            noMovieDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
