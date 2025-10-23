//
//  AppDelegate.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 01.10.2025.
//

import UIKit
import CoreData

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let sceneConfigs = CASSceneConfiguration.sceneConfiguration
        let configuration = sceneConfigs[connectingSceneSession.role]!
        
        return UISceneConfiguration(
            name: configuration.identifier,
            sessionRole: configuration.role
        )
    }

}

