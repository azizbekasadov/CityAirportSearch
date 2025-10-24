//
//  CityCell.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 25.10.2025.
//

import UIKit

final class CityCell: UITableViewCell {
    private let citylabel: UILabel = {
        let label = UILabel()
        label.text = "City"
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationlabel: UILabel = {
        let label = UILabel()
        label.text = "State, Country"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline).withSize(15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [citylabel, locationlabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    func configure(using viewModel: CityViewPresentable) {
        citylabel.text = viewModel.city
        locationlabel.text = viewModel.location
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 12),
        ])
    }
}
