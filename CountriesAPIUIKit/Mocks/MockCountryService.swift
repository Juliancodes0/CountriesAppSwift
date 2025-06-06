//
//  MockCountryService.swift
//  CountriesAPIUIKit
//
//  Created by Julian on 6/6/25.
//

import Foundation

class MockCountryService: CountryService {
    let result: Result<[Country], Error>

    init(result: Result<[Country], Error>) {
        self.result = result
    }

    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        completion(result)
    }
}
