//
//  File.swift
//  MoviesApp
//
//  Created by Asif Hussain on 29/07/2024.
//

import Foundation

import UIKit

class LoadingIndicatorCell: UICollectionViewCell {
    static let identifier = "LoadingIndicatorCell"
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .orange
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       configureUI()
    }
    private func configureUI(){
        contentView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
