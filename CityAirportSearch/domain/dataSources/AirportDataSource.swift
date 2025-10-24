//
//  AirportDataSource.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 24.10.2025.
//

import RxSwift
import Foundation

protocol AirportDataSource {
    func fetchAirports() -> Single<[Airport]>
}
