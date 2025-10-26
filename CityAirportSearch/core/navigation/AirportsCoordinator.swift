//
//  AirportsCoordinator.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 26.10.2025.
//

import UIKit
import RxCocoa

final class AirportsCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController!) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let rootViewController = AirportsViewController()
        
        
        navigationController.pushViewController(
            rootViewController,
            animated: true
        )
    }
}
