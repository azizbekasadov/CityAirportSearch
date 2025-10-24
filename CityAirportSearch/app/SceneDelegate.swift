//
//  SceneDelegate.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 01.10.2025.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private var appCoordinator: Coordinator!
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            fatalError("No Window Scene allocated for this app")
        }
        
        self.window = UIWindow(windowScene: windowScene)
        
        guard let window else { return }
        
        appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
    }
}

