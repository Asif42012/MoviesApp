//
//  Coordinator.swift
//  MoviesApp
//
//  Created by Asif Hussain on 24/07/2024.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
