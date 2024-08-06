//
//  AboutMovieView.swift
//  MoviesApp
//
//  Created by Asif Hussain on 30/07/2024.
//

import UIKit

class AboutMovieView: UIScrollView {
    
    let aboutMovieLabel: UILabel = {
        let aboutMovieLabel = UILabel()
        aboutMovieLabel.font = AppFont.medium12
        aboutMovieLabel.textColor = .white
        aboutMovieLabel.numberOfLines = 0
        aboutMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        return aboutMovieLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private func configureUI(){
        addSubview(aboutMovieLabel)
        translatesAutoresizingMaskIntoConstraints = false
        isScrollEnabled = true
        alwaysBounceVertical = true
        alwaysBounceHorizontal = false
        isDirectionalLockEnabled = true
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstrains() {
        NSLayoutConstraint.activate([
            aboutMovieLabel.topAnchor.constraint(equalTo: topAnchor),
            aboutMovieLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            aboutMovieLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            aboutMovieLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            aboutMovieLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -32) // 16 + 16 for padding
        ])
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let contentHeight = aboutMovieLabel.sizeThatFits(CGSize(width: aboutMovieLabel.frame.width, height: CGFloat.greatestFiniteMagnitude)).height + 20
        contentSize = CGSize(width: frame.width, height: contentHeight)
    }
}
