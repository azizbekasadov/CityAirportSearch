//
//  CASSceneConfiguration.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 23.10.2025.
//

import UIKit

typealias CASSceneConfigurationIdentifier = String
typealias CASSceneConfigurationRole = UISceneSession.Role

struct CASSceneConfiguration: Identifiable {
    let id: UUID
    let role: CASSceneConfigurationRole
    let identifier: CASSceneConfigurationIdentifier
    
    init(
        id: UUID = .init(),
        role: CASSceneConfigurationRole,
        identifier: CASSceneConfigurationIdentifier
    ) {
        self.id = id
        self.role = role
        self.identifier = identifier
    }
}

extension CASSceneConfiguration {
    static let sceneConfiguration: [CASSceneConfigurationRole: CASSceneConfiguration] = [
        .windowApplication : CASSceneConfiguration(
            role: .windowApplication,
            identifier: "Default Configuration"
        )
    ]
}
