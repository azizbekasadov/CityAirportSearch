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

final class SearchViewController: UIViewController {
    
    private var viewModel: SearchViewPresentable!
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<CityItemsSection>(configureCell: { _, tableView, indexPath, item in
        let cityCell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! CityCell
        cityCell.configure(using: item)
        return cityCell
    })
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = 56.0
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = UIColor.clear
        return searchBar
    }()
    
    private var disposeBag: DisposeBag = .init()
    
    var viewModelBuilder: SearchViewPresentable.ViewBuilder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do not change the order of the funcs()
        setupNavigationBar()
        setupViews()
        setupViewModel()
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.onAppear()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(tableView)
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupViewModel() {
        viewModel = viewModelBuilder(
            (
                searchText: searchBar.rx.text.orEmpty.asDriver(),
                citySelected: tableView.rx.modelSelected(CityViewPresentable.self).asDriver()
            )
        )
    }
    
    private func setupNavigationBar() {
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
