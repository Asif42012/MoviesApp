//
//  EmptySearchResults.swift
//  MoviesApp
//
//  Created by Asif Hussain on 05/08/2024.
//

import UIKit

class EmptySearchResults: UIView {
    
    let searchImage: UIImageView = {
       let searchImage = UIImageView(image: UIImage(named: "Ic_not_found"))
        searchImage.contentMode = .scaleAspectFit
        searchImage.translatesAutoresizingMaskIntoConstraints = false
        return searchImage
    }()
    
    let noResultLabel: UILabel = {
       let noResultLabel = UILabel()
        noResultLabel.text = "We Are Sorry, We Can\nNot Find The Movie :("
        noResultLabel.font = AppFont.regularPoppin16
        noResultLabel.textColor = .white
        noResultLabel.numberOfLines = 2
        noResultLabel.textAlignment = .center
        noResultLabel.translatesAutoresizingMaskIntoConstraints = false
        return noResultLabel
    }()
    
    let noResultDescriptionLabel: UILabel = {
       let noResultDescriptionLabel = UILabel()
        noResultDescriptionLabel.font = AppFont.medium12
        noResultDescriptionLabel.textColor = UIColor(red: 146/255, green: 146/255, blue: 157/255, alpha: 1)
        noResultDescriptionLabel.numberOfLines = 2
        noResultDescriptionLabel.textAlignment = .center
        noResultDescriptionLabel.text = "Find your movie by Type title,\ncategories, years, etc "
        noResultDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return noResultDescriptionLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchImage)
        addSubview(noResultLabel)
        addSubview(noResultDescriptionLabel)
        translatesAutoresizingMaskIntoConstraints = false
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstrains(){
        NSLayoutConstraint.activate([
            searchImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchImage.topAnchor.constraint(equalTo: topAnchor),
            searchImage.heightAnchor.constraint(equalToConstant: 76),
            searchImage.widthAnchor.constraint(equalToConstant: 76),
            
            noResultLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            noResultLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            noResultLabel.topAnchor.constraint(equalTo: searchImage.bottomAnchor, constant: 20),
            
            noResultDescriptionLabel.topAnchor.constraint(equalTo: noResultLabel.bottomAnchor, constant: 10),
            noResultDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            noResultDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            noResultDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}
