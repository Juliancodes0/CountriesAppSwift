//
//  ViewController.swift
//  CountriesAPIUIKit
//
//  Created by Julian Burton on 6/6/25
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var viewModel: ViewModel = ViewModel(countryService: NetworkManager())
    var countriesTableView = UITableView()
    var searchField = UISearchTextField()
    var originalList: [Country] = []
    let noResultsLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        arrange()
        style()
        searchField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.downloadCountryData {
            DispatchQueue.main.async {
                self.originalList = self.viewModel.countries
                self.countriesTableView.reloadData()
            }
        }
    }
    
    func setup() {
        view.addSubview(searchField)
        view.addSubview(countriesTableView)
        view.addSubview(noResultsLabel)
        
        countriesTableView.translatesAutoresizingMaskIntoConstraints = false
        searchField.translatesAutoresizingMaskIntoConstraints = false
        noResultsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        countriesTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
    }
    
    func arrange() {
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchField.heightAnchor.constraint(equalToConstant: 40),
            
            countriesTableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 12),
            countriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            countriesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            noResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func style() {
        view.backgroundColor = .systemGroupedBackground
        
        searchField.placeholder = "Search countries..."
        searchField.layer.cornerRadius = 8
        searchField.layer.borderWidth = 1
        searchField.layer.borderColor = UIColor.systemGray4.cgColor
        searchField.backgroundColor = .systemBackground
        searchField.clearButtonMode = .whileEditing
        
        countriesTableView.backgroundColor = .clear
        countriesTableView.separatorStyle = .singleLine
        
        noResultsLabel.text = "No countries found."
        noResultsLabel.textColor = .secondaryLabel
        noResultsLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        noResultsLabel.isHidden = true
    }
    
    @objc func searchTextChanged() {
        guard let searchText = searchField.text else { return }

        viewModel.search(by: searchText)
        noResultsLabel.isHidden = !viewModel.countries.isEmpty
        countriesTableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.identifier, for: indexPath
        ) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        let country = viewModel.countries[indexPath.row]
        cell.setProperties(countryText: country.name, capital: country.capital, region: country.region)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchField.resignFirstResponder()
    }
}
