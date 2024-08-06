//
//  MovieYearView.swift
//  MoviesApp
//
//  Created by Asif Hussain on 30/07/2024.
//

import UIKit

class MovieYearView: UIView {
    
    let movieYearLabel: UILabel = {
        let movieYearLabel = UILabel()
        movieYearLabel.font = AppFont.medium12
        movieYearLabel.textColor = UIColor(red: 146/255, green: 146/255, blue: 157/255, alpha: 1)
        movieYearLabel.translatesAutoresizingMaskIntoConstraints = false
        return movieYearLabel
    }()
    
    let movieYearIcon: UIImageView = {
        let movieYearIcon = UIImageView()
        movieYearIcon.image = UIImage(named: "Ic_calender")
        movieYearIcon.translatesAutoresizingMaskIntoConstraints = false
        return movieYearIcon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private func configureUI(){
        addSubview(movieYearIcon)
        addSubview(movieYearLabel)
        setUpViews()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpViews() {
        NSLayoutConstraint.activate([
            movieYearIcon.topAnchor.constraint(equalTo: topAnchor),
            movieYearIcon.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieYearIcon.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            movieYearLabel.topAnchor.constraint(equalTo: topAnchor),
            movieYearLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieYearLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            heightAnchor.constraint(equalToConstant: 16),
            widthAnchor.constraint(equalToConstant: 47),
        ])
    }
}
