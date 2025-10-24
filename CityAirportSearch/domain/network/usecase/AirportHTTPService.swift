//
//  AirportHTTPService.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 24.10.2025.
//

import Alamofire
import Foundation

final class AirportHTTPService: HTTPService {
    var session: Alamofire.Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func request(_ urlRequest: URLRequest) -> DataRequest {
        self.session.request(urlRequest)
    }
}
