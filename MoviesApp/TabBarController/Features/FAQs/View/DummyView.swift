//
//  DummyView.swift
//  MoviesApp
//
//  Created by Asif Hussain on 16/08/2024.
//

import UIKit

class DummyView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
