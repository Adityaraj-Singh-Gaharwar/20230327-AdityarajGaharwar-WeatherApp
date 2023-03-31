//
//  CitySearchVC.swift
//  20230327-AdityarajGaharwar-WeatherApp
//
//  Created by Adityaraj Singh Gaharwar on 31/03/23.
//

import UIKit
/* This class is used for searching city and passing the data to WeatherVC */
class CitySearchVC: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var tblViewCities: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchNavigationBar: UINavigationBar!
    
    //MARK: - Variables
    var viewModel = SearchVM()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    //MARK: - Actions
    @IBAction func btnBackTap(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    //MARK: - flow func
    private func updateUI() {
        view.backgroundColor = .clear
        searchNavigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        searchNavigationBar.topItem?.title = "Location"
        searchNavigationBar.tintColor = .white
        searchBar.delegate = self
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    private func bind() {
        viewModel.reloadTablView = {
            DispatchQueue.main.async { self.tblViewCities.reloadData() }
        }
        viewModel.getCity()
    }
}

//MARK: - Extensions
// Search delegate
extension CitySearchVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else { return }
        viewModel.searchCity(text: text)
    }
    
}

extension CitySearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchCity(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchCity(text: searchBar.text!)
        self.searchBar.endEditing(true)
    }
}
// Tableview datasource and delegates
extension CitySearchVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return viewModel.numberOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        if viewModel.filteredCityIsEmpty() {
            
            guard let locationCell = tableView.dequeueReusableCell(withIdentifier: Cell.currentLocation, for: indexPath) as? CurrentLocationCell else { return UITableViewCell() }
            locationCell.configure()
            return locationCell
            
        } else {
            
            guard let searchCell = tableView.dequeueReusableCell(withIdentifier: Cell.city, for: indexPath) as? CityCell else { return UITableViewCell() }
            let cellVieModel = viewModel.getCellViewModel(at: indexPath)
            searchCell.configure(filteredCities: cellVieModel)
            return searchCell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.didSelectRow(at: indexPath)
        self.dismiss(animated: true)

    }
    
    
}
