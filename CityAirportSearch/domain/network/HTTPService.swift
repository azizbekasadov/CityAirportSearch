//
//  HTTPService.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 24.10.2025.
//

import Foundation
import Alamofire

protocol HTTPService {
    var session: Session { get set }
    
    func request(
        _ urlRequest: URLRequest
    ) -> DataRequest
}
