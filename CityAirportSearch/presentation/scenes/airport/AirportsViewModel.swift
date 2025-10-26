//
//  AirportsViewModel.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 26.10.2025.
//

import Foundation

protocol AirportsViewPresentable {
    typealias Output = ()
    typealias Input = ()
    
    var output: AirportsViewPresentable.Output { get set }
    var input: AirportsViewPresentable.Input { get set }
}

struct AirportsViewModel: AirportsViewPresentable {
    
    var output: AirportsViewPresentable.Output
    var input: AirportsViewPresentable.Input
    
    
}
