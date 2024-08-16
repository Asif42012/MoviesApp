//
//  GemImageView.swift
//  MoviesApp
//
//  Created by Asif Hussain on 16/08/2024.
//

import UIKit

class GemImageView: UIView {
    
    let gemImageView: UIImageView = {
       let gemImageView = UIImageView(image: UIImage(named: "Ic_gem"))
        gemImageView.contentMode = .scaleAspectFit
        gemImageView.translatesAutoresizingMaskIntoConstraints = false
        return gemImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(gemImageView)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 82),
            
            gemImageView.topAnchor.constraint(equalTo: topAnchor),
            gemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gemImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gemImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
