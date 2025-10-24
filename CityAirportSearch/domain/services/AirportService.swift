//
//  AirportService.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 24.10.2025.
//

import RxSwift
import Foundation
import Alamofire

enum AirportServiceError: String, Error {
    case selfIsNotStrong
    case invalidData
}

final class AirportService: NSObject {
    private let router: NetworkRouter
    private let networkService: HTTPService
    
    init(
        networkService: HTTPService,
        router: NetworkRouter
    ) {
        self.networkService = networkService
        self.router = router
    }
}

extension AirportService: AirportDataSource {
    
    func fetchAirports() -> Single<[Airport]> {
        Single.create { [weak self] (single) -> Disposable in
            guard let strongSelf = self else {
                return Disposables.create()
            }
            
            do {
                try strongSelf.router
                    .request(using: strongSelf.networkService)
                    .responseJSON { @MainActor response in
                        do {
                            guard let data = response.data else {
                                return
                            }
                            
                            let airports = try JSONDecoder().decode([Airport].self, from: data)
                            print(airports.prefix(10))
                            single(.success(airports))
                        } catch {
                            print(error.localizedDescription)
                            single(.failure(error))
                        }
                    }
            } catch {
                print(error.localizedDescription)
                single(.failure(error))
            }
            
            return Disposables.create()
        }
    }
}
