//
//  NetworkRouter.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 24.10.2025.
//

import Alamofire
import Foundation

protocol NetworkRouter {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    
    func body() throws -> Data?
    func request(using httpService: HTTPService) throws -> DataRequest
}

extension NetworkRouter {
    var headers: HTTPHeader? {
        return nil
    }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
    
    func body() throws -> Data? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: self.baseURL) else {
            throw NetworkError.badURL
        }
        
        let finalURL = url.appending(path: self.path)
        
        var request = try URLRequest(
            url: finalURL,
            method: self.method,
            headers: headers
        )
        request.httpBody = try self.body()
        
        return request
    }
    
    func request(using httpService: HTTPService) throws -> DataRequest {
        let urlRequest = try self.asURLRequest()
        return httpService.request(urlRequest).validate(statusCode: 200..<400)
    }
}
