//
//  AirportHTTPRouter.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 24.10.2025.
//

import Alamofire
import Foundation

enum AirportHTTPRouter {
    case getAirports
}

extension AirportHTTPRouter: NetworkRouter {
    
    var baseURL: String {
        switch self {
        case .getAirports:
            return "https://gist.githubusercontent.com/tdreyno/4278655/raw/7b0762c09b519f40397e4c3e100b097d861f5588"
        }
    }
    
    var path: String {
        switch self {
        case .getAirports:
            return "airports.json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAirports:
            return .get
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getAirports:
            return ["content-type": "application/json"]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getAirports:
            return nil
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getAirports:
            return nil
        }
    }
}
