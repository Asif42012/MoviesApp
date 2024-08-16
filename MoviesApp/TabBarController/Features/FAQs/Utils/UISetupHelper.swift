//
//  UISetupHelper.swift
//  MoviesApp
//
//  Created by Asif Hussain on 16/08/2024.
//

import UIKit

struct UISetupHelper {
    
    static func setupHeaderView(in parentView: UIView, headerView: NavBarView) {
        headerView.backButton.tintColor = .systemPink
        headerView.backButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        let navBarView = UIView()
        navBarView.backgroundColor = .white
        navBarView.translatesAutoresizingMaskIntoConstraints = false
        navBarView.addSubview(headerView)
        parentView.addSubViewsWithAutoLayout(navBarView)
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor),
            headerView.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor),
            headerView.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor),
            navBarView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            navBarView.topAnchor.constraint(equalTo: parentView.topAnchor),
            navBarView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            navBarView.heightAnchor.constraint(equalToConstant: 103)
        ])
    }
    
    static func setupScrollView(in parentView: UIView, scrollView: UIScrollView, below headerView: UIView) {
        parentView.addSubViewsWithAutoLayout(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ])
    }
    
    static func setupTopStackButtons(in scrollView: UIScrollView, categoryButtons: CategorySelectionView, delegate: CategorySelectionViewDelegate) {
        
        categoryButtons.delegate = delegate
        scrollView.addSubViewsWithAutoLayout(categoryButtons)
        
        NSLayoutConstraint.activate([
            categoryButtons.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            categoryButtons.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            categoryButtons.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])
    }
    
    static func setupContentView(in scrollView: UIScrollView, contentView: FAQContentView, below categoryButtons: UIView, parentView: UIView, delegate: FAQContentViewDelegate) {
        scrollView.addSubViewsWithAutoLayout(contentView)
        contentView.delegate = delegate
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: categoryButtons.bottomAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            
            contentView.widthAnchor.constraint(equalTo: parentView.widthAnchor)
        ])
    }
}

