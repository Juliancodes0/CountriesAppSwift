//
//  ViewModel.swift
//  CountriesAPIUIKit
//
//  Created by Julian Burton on 6/6/25
//

import Foundation

class ViewModel {
    var countries: [Country] = []

    func downloadCountryData (completion: @escaping () -> ()) {
        NetworkManager.downloadDataFromURLString(urlString: "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json", type: [Country].self) { result in
            switch result {
            case .success(let countries):
                    self.countries = countries
                    completion()
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }
        }
    }
}



















