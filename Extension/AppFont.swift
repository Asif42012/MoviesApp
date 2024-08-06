//
//  AppFont.swift
//  MoviesApp
//
//  Created by Asif Hussain on 24/07/2024.
//

import Foundation
import UIKit

enum AppFont {
    static let medium12 = UIFont(name: Roboto.medium.rawValue, size: 12)
    static let mediumPoppin18 = UIFont(name: Poppins.regular.rawValue, size: 18)
    static let regularPoppin14 = UIFont(name: Poppins.regular.rawValue, size: 14)
    static let regularPoppin16 = UIFont(name: Poppins.regular.rawValue, size: 16)
    static let regularPoppin32 = UIFont(name: Poppins.regular.rawValue, size: 32)
    static let bold12 = UIFont(name: Poppins.bold.rawValue, size: 12)
    static func custom(weight: Roboto, size: CGFloat) -> UIFont? {
        return UIFont(name: weight.rawValue, size: size)
    }
    static let tabBackgroundColor = UIColor(red: 36/255, green: 42/255, blue: 50/255, alpha: 1)
}

enum Roboto: String {
    case black = "Roboto-Black"
    case bold = "Roboto-Bold"
    case thin = "Roboto-Thin"
    case medium = "Roboto-Medium"
    case regular = "Roboto-Regular"
    case light = "Roboto-Light"
}

enum Poppins: String {
    case regular = "Poppins-Regular"
    case medium = "Poppins-Medium"
    case light = "Poppins-Light"
    case semiBold = "Poppins-SemiBold"
    case bold = "Poppins-Bold"
}
