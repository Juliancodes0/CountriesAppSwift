//
//  CountryService.swift
//  CountriesAPIUIKit
//
//  Created by Julian on 6/6/25.
//

import Foundation

protocol CountryService {
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void)
}
