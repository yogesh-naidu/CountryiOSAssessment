//
//  CountriesViewModel.swift
//  Assignment
//

import Foundation

class CountriesViewModel {
    var countries: [Country] = []
    var filteredCountries: [Country] = []
    
    var onDataUpdated: (() -> Void)?

    func fetchCountries() {
        NetworkManager.shared.fetchCountries { [weak self] result in
            switch result {
            case .success(let countries):
                self?.countries = countries
                self?.filteredCountries = countries
                self?.onDataUpdated?()
            case .failure( _):
                self?.countries = []
                self?.filteredCountries = []
                self?.onDataUpdated?()
            }
        }
    }
    
    func resetFilter() {
        filteredCountries = countries
    }

    func filterCountries(searchText: String) {
        if searchText.isEmpty {
            filteredCountries = countries
        } else {
            filteredCountries = countries.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.capital.lowercased().contains(searchText.lowercased())
            }
        }
        onDataUpdated?()
    }
}
