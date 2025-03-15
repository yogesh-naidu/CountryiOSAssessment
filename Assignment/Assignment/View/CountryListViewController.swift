//
//  CountryListViewController.swift
//  Assignment
//

import UIKit


final class CountryListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return activityIndicator
    }()
   
    private let viewModel = CountriesViewModel()
    private let searchController = SearchCountryListViewController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        activityIndicator.startAnimating()
        viewModel.fetchCountries()
    }

    private func setupUI() {
        title = "Countries"
        view.backgroundColor = .white
        view.addSubview(activityIndicator)
        
        // Search controller
        setupSearchController()
        
        // Configure TableView
        configureTableView()
    }

    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                guard let weakSelf = self,
                    !weakSelf.viewModel.filteredCountries.isEmpty else {
                    self?.tableView.isHidden = true
                    self?.presentAlertView()
                    return
                }
                weakSelf.tableView.isHidden = false
                weakSelf.tableView.reloadData()
            }
        }
    }
    
    private func presentAlertView() {
        let alertController = UIAlertController(title: "Failed", message: "Unable to load the country details", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Retry", style: .cancel) {[weak self] _ in
            self?.viewModel.fetchCountries()
            alertController.dismiss(animated: true)
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.register(CountryCellTableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    private func setupSearchController() {
        searchController.searchDelegate = self
        navigationItem.searchController = searchController
    }
}

// MARK: - TableView DataSource Methods
extension CountryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard viewModel.filteredCountries.count > 0 else {
            tableView.setEmptyMessage("No records match your search criteria")
            return 0
        }
        
        tableView.restore()
        return viewModel.filteredCountries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CountryCellTableViewCell
        let country = viewModel.filteredCountries[indexPath.row]
        cell.configure(with: country)
        return cell
    }
}

// MARK: - SearchCountryListViewControllerDelegate Methods
extension CountryListViewController: SearchCountryListViewControllerDelegate {
    func didSearchButtonTap() {
        viewModel.resetFilter()
        tableView.reloadData()
    }
    
    func didUpdateSearchResults(_ searchText: String) {
        viewModel.filterCountries(searchText: searchText)
        tableView.reloadData()
    }
}

