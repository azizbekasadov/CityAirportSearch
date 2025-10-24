//
//  CityViewModelk.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 25.10.2025.
//

import Foundation
import CoreLocation
import RxDataSources

typealias CityItemsSection = SectionModel<Int, CityViewPresentable>

protocol CityViewPresentable {
    var city: String { get }
    var location: String { get }
}

struct CityViewModel: CityViewPresentable {
    var city: String
    var location: String
    
    init(
        city: String,
        location: String
    ) {
        self.city = city
        self.location = location
    }
}

extension CityViewModel {
    init(airport: Airport) {
        self.city = airport.city
        self.location = "\(airport.country) \(airport.coordinates.latitude)/\(airport.coordinates.longitude)"
    }
}

extension CityViewModel: Equatable {
    static func == (_ lhs: CityViewModel, _ rhs: CityViewModel) -> Bool {
        lhs.city == rhs.city
    }
}

extension CityViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.city)
    }
}
