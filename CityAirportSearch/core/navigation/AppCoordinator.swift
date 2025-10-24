//
//  AppCoordinator.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 24.10.2025.
//

import UIKit

@MainActor
final class AppCoordinator: BaseCoordinator {
    private let window: UIWindow
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        let navigationBar = navigationController.navigationBar
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = UIColor.blue
        navigationBar.barTintColor = UIColor.systemBackground
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let navigationController = UINavigationController()
        
        let searchCoordinator = SearchCoordinator(
            navigationController: navigationController
        )
        add(searchCoordinator)
        searchCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
