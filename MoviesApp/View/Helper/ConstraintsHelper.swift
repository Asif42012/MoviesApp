//
//  ConstraintsHelper.swift
//  MoviesApp
//
//  Created by Asif Hussain on 15/08/2024.
//

import Foundation
import UIKit

final class ConstraintsHelper {
    
    static func constrains(with view: UIView, headerView: UIView, noMovieView: UIView) {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            noMovieView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            noMovieView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            noMovieView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noMovieView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    static func searchConstraints(with view: UIView, headerView: UIView, searchBar: UIView, noResult: UIView) {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchBar.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 42),
            
            noResult.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            noResult.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            noResult.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResult.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
