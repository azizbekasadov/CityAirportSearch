//
//  Coordinator.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 23.10.2025.
//

import Foundation

@MainActor
public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    func add(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func remove(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
