//
//  SearchViewModel.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 23.10.2025.
//

import RxCocoa
import RxSwift
import Foundation
internal import Differentiator

protocol SearchViewPresentable: AnyObject {
    typealias Input = (
        searchText: Driver<String>,
        citySelected: Driver<CityViewPresentable>
    )
    typealias Output = (
        cities: Driver<[CityItemsSection]>, ()
    )
    typealias State = (airports: BehaviorRelay<Set<Airport>>, ())
    typealias ViewBuilder = (SearchViewPresentable.Input) -> SearchViewPresentable
    
    var input: SearchViewPresentable.Input { get }
    var output: SearchViewPresentable.Output { get }
    
    func onAppear()
}

final class SearchViewModel: SearchViewPresentable {
    private var airportService: AirportService
    private var disposeBag = DisposeBag()
    
    private var state: State = (airports: BehaviorRelay(value: []), ())
    
    private(set) var isLoading: Bool = false
    
    var input: SearchViewPresentable.Input
    var output: SearchViewPresentable.Output
    
    private typealias RoutingAction = (citySelected: PublishRelay<Set<Airport>>, ())
    typealias Routing = (citySelected: Driver<Set<Airport>>, ())
    
    private let routingAction: RoutingAction = (citySelected: PublishRelay(), ())
    
    lazy var router: Routing = (citySelected: self.routingAction.citySelected.asDriver(onErrorDriveWith: .empty()), ())
    
    init(
        input: SearchViewPresentable.Input,
        airportService: AirportService
    ) {
        self.input = input
        self.airportService = airportService
        
        self.output = SearchViewModel.output(
            input,
            state: state
        )
    }
    
    func onAppear() {
        isLoading = true
        self.process()
    }
    
}

private extension SearchViewModel {
    static func output(
        _ input: SearchViewPresentable.Input,
        state: SearchViewPresentable.State
    ) -> SearchViewPresentable.Output {
        
        let searchTextPublisher = input.searchText
            .debounce(.milliseconds(500))
            .distinctUntilChanged()
            .skip(1) // skip the first val
            .asObservable()
            .share(
                replay: -1,
                scope: .whileConnected
            )
        
        // for the proper search
        let airportsDataSourcePublisher = state.airports
            .skip(1) // skip the first val
            .asObservable()
        
        let sections = Observable.combineLatest(
            searchTextPublisher,
            airportsDataSourcePublisher
        )
        .map { (searchKey, airports) in
            airports.filter {
                !searchKey.isEmpty && $0.city.lowercased().replacingOccurrences(of: " ", with: "").hasPrefix(searchKey)
            }
        }
        .map { @MainActor in
            SearchViewModel.uniqueElementsFrom(
                $0.compactMap(CityViewModel.init)
            )
        }
        .map {
            [CityItemsSection(
                model: 0,
                items: $0
            )]
        }
        .asDriver(onErrorJustReturn: [])
        
        return (
            cities: sections, ()
        )
    }
    
    // register subscribers to the publishers
    func process() {
        airportService
            .fetchAirports()
            .map { [weak self, state] in
                state.airports.accept(Set($0))
                
                self?.isLoading = false
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        input.citySelected
            .map { $0.city }
            .withLatestFrom(state.airports.asDriver()) {
                (city: $0, airports: $1)
            }
            .map { city, airports in
                airports.filter { $0.city == city }
            }
            .map { [routingAction] in
                routingAction.citySelected.accept($0)
            }
            .drive()
            .disposed(by: disposeBag)
    }
}

private extension SearchViewModel {
    static func uniqueElementsFrom(
        _ collection: [CityViewModel]
    ) -> [CityViewModel] {
        var setCities = Set<CityViewModel>()
        
        let result = collection.filter {
            guard !setCities.contains($0) else {
                return false
            }
            
            setCities.insert($0)
            return true
        }
        
        return result
    }
}
