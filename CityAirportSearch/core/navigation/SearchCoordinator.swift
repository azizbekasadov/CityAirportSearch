//
//  SearchCoordinator.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 24.10.2025.
//

import Foundation
import UIKit

final class SearchCoordinator: BaseCoordinator {
    private(set) var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let rootViewController = SearchViewController()
        
        rootViewController.viewModelBuilder = { input in
            SearchViewModel(
                input: input,
                airportService: AirportService(
                    networkService: AirportHTTPService(),
                    router: AirportHTTPRouter.getAirports
                )
            )
        }
        
        navigationController.setViewControllers(
            [rootViewController],
            animated: true
        )
    }
}
