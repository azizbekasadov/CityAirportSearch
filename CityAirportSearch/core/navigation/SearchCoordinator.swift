//
//  SearchCoordinator.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 24.10.2025.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchCoordinator: BaseCoordinator {
    private(set) var navigationController: UINavigationController!
    
    private var disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let rootViewController = SearchViewController()
        
        rootViewController.viewModelBuilder = { [weak self] input in
            guard let self else { fatalError() }
            
            let viewModel = SearchViewModel(
                input: input,
                airportService: AirportService(
                    networkService: AirportHTTPService(),
                    router: AirportHTTPRouter.getAirports
                )
            )
            viewModel.router.citySelected.map { [weak self] models in
                self?.showAiports(using: models)
            }
            .drive()
            .disposed(by: disposeBag)
            
            
            return viewModel
        }
        
        navigationController.setViewControllers(
            [rootViewController],
            animated: true
        )
    }
}

private extension SearchCoordinator {
    func showAiports(using models: Set<Airport>) {
        let airportsCoordinator = AirportsCoordinator(
            navigationController: self.navigationController
        )
        add(airportsCoordinator)
        
        airportsCoordinator.start()
    }
}
