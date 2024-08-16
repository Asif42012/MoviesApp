//
//  LabelFactory.swift
//  MoviesApp
//
//  Created by Asif Hussain on 16/08/2024.
//

import UIKit

class LabelFactory {
    static func createTabBarLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.font = AppFont.medium12
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

