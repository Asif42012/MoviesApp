//
//  LoadImage.swift
//  MoviesApp
//
//  Created by Asif Hussain on 25/07/2024.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    func downloadImages(with urlString: String, placeholder: String = "placeholder", dummyAvatar: String = "person.fill") {
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        if let imageURL = URL(string: baseUrl + urlString) {
            self.sd_setImage(with: imageURL, placeholderImage: UIImage(named: placeholder))
        } else {
            // Use a system icon as the dummy avatar if the URL is nil or empty
            if let systemImage = UIImage(systemName: dummyAvatar) {
                self.image = systemImage
            } else {
                // Fallback to a local placeholder image if the system icon is not available
                self.image = UIImage(named: placeholder)
            }
        }
    }
    
}
