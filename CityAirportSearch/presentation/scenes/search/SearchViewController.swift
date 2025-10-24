//
//  SearchViewController.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 23.10.2025.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class SearchViewController: UITableViewController {
    
    private var viewModel: SearchViewPresentable!
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<CityItemsSection>(configureCell: { _, tableView, indexPath, item in
        let cityCell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! CityCell
        cityCell.configure(using: item)
        return cityCell
    })
    
    private var disposeBag: DisposeBag = .init()
    
    var viewModelBuilder: SearchViewPresentable.ViewBuilder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do not change the order of the funcs()
        setupNavigationBar()
        setupViewModel()
    }
    
    private func setupViewModel() {
        guard let searchBar = navigationItem.searchController?.searchBar else {
            fatalError("A SearchBar field must be set to be used")
        }
        
        viewModel = viewModelBuilder(
            (searchText: searchBar.rx.text.orEmpty.asDriver(), ())
        )
    }
    
    private func setupNavigationBar() {
        navigationItem.searchController = UISearchController(searchResultsController: UITableViewController(style: .plain))
        
        if #available(iOS 26, *) {
            navigationItem.largeTitle = "Airports"
        }
        
        navigationItem.title = "Airports"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupBindings() {
        viewModel.output.cities.drive(
            tableView.rx.items(
                dataSource: dataSource
            )
        )
        .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        tableView.register(CityCell.self, forCellReuseIdentifier: "cellid")
    }
}
