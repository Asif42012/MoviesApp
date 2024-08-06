//
//  ThickSlider.swift
//  MoviesApp
//
//  Created by Asif Hussain on 06/08/2024.
//

import Foundation
import UIKit

import UIKit

class ThickSlider: UISlider {
    var trackHeight: CGFloat = 8.0 // Adjust the height as needed

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.trackRect(forBounds: bounds)
        let customRect = CGRect(x: originalRect.origin.x, y: originalRect.origin.y + (originalRect.height - trackHeight) / 2, width: originalRect.width, height: trackHeight)
        return customRect
    }
}

