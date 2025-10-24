//
//  BaseCoordinator.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 24.10.2025.
//

import Foundation
import UIKit

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    func start() {
        fatalError("BaseCoordinator: Children must implement `start()`")
    }
}
