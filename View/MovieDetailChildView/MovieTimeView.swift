//
//  MovieTimeView.swift
//  MoviesApp
//
//  Created by Asif Hussain on 30/07/2024.
//

import UIKit

class MovieTimeView: UIView {
    
    let movieTimeLabel: UILabel = {
        let movieTimeLabel = UILabel()
        movieTimeLabel.font = AppFont.medium12
        movieTimeLabel.textColor = UIColor(red: 146/255, green: 146/255, blue: 157/255, alpha: 1)
        movieTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return movieTimeLabel
    }()
    
    let movieTimeIcon: UIImageView = {
        let movieYearIcon = UIImageView()
        movieYearIcon.image = UIImage(named: "Ic_clock")
        movieYearIcon.translatesAutoresizingMaskIntoConstraints = false
        return movieYearIcon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(movieTimeIcon)
        addSubview(movieTimeLabel)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            movieTimeIcon.topAnchor.constraint(equalTo: topAnchor),
            movieTimeIcon.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieTimeIcon.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            movieTimeLabel.topAnchor.constraint(equalTo: topAnchor),
            movieTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightAnchor.constraint(equalToConstant: 16),
            widthAnchor.constraint(equalToConstant: 85),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
