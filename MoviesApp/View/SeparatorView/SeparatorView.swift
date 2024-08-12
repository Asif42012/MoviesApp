//
//  SeparatorView.swift
//  MoviesApp
//
//  Created by Asif Hussain on 29/07/2024.
//

import UIKit

class SeparatorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(red: 146/255, green: 146/255, blue: 157/255, alpha: 1)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

