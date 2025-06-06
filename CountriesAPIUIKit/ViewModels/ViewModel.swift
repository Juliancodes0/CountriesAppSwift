//
//  ViewModel.swift
//  CountriesAPIUIKit
//
//  Created by Julian Burton on 6/6/25
//

import Foundation

class ViewModel {
    private let countryService: CountryService

    private var allCountries: [Country] = []

    private(set) var countries: [Country] = []

    init(countryService: CountryService) {
        self.countryService = countryService
    }

    func downloadCountryData(completion: @escaping () -> Void) {
        countryService.fetchCountries { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let countries):
                self.allCountries = countries
                self.countries = countries
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.allCountries = []
                self.countries = []
            }
            completion()
        }
    }

    func search(by keyword: String) {
        let trimmed = keyword.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            countries = allCountries
            return
        }

        let lowercasedKeyword = trimmed.lowercased()
        countries = allCountries.filter {
            $0.name.lowercased().contains(lowercasedKeyword) ||
            $0.region.lowercased().contains(lowercasedKeyword) ||
            $0.capital.lowercased().contains(lowercasedKeyword)
        }
    }

    func filter(by region: String) {
        countries = allCountries.filter { $0.region == region }
    }

    func resetCountries() {
        countries = allCountries
    }
}
















