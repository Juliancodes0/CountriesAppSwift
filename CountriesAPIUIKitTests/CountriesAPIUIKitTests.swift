//
//  CountriesAPIUIKitTests.swift
//  CountriesAPIUIKitTests
//
//  Created by Julian 沙 on 1/16/24.
//

import XCTest

final class CountriesAPIUIKitTests: XCTestCase {
    
    func testDownload() {
        let expectation = self.expectation(description: "Download was successful")
        
        NetworkManager.downloadDataFromURLString(
            urlString: "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json",
            type: [Country].self
        ) { result in
            switch result {
            case .success(let decoded):
                XCTAssertFalse(decoded.isEmpty)
            case .failure(let error):
                XCTFail("Failed with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testFetchCountriesSuccess() {
        let mockData = [
            Country(capital: "Paris", name: "France", region: "Europe"),
            Country(capital: "Berlin", name: "Germany", region: "Europe")
        ]
        
        let viewModel = ViewModel(countryService: MockCountryService(result: .success(mockData)))
        let expectation = expectation(description: "Successful fetch")
        
        viewModel.downloadCountryData {
            XCTAssertEqual(viewModel.countries.count, 2)
            XCTAssertEqual(viewModel.countries.first?.name, "France")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchCountriesFail() {
        let viewModel = ViewModel(countryService: MockCountryService(result: .failure(NetworkError.defaultError)))
        let expectation = expectation(description: "Failed fetch")
        
        viewModel.downloadCountryData {
            XCTAssertEqual(viewModel.countries.count, 0)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFilterCountries() {
        let mockData = [
            Country(capital: "Paris", name: "France", region: "Europe"),
            Country(capital: "Berlin", name: "Germany", region: "Europe"),
            Country(capital: "Canberra", name: "Australia", region: "Oceania")
        ]
        
        let viewModel = ViewModel(countryService: MockCountryService(result: .success(mockData)))
        let expectation = expectation(description: "Filter by region")
        
        viewModel.downloadCountryData {
            viewModel.filter(by: "Europe")
            XCTAssertEqual(viewModel.countries.count, 2)
            XCTAssertTrue(viewModel.countries.allSatisfy { $0.region == "Europe" })
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testResetFilter() {
        let mockData = [
            Country(capital: "Paris", name: "France", region: "Europe"),
            Country(capital: "Canberra", name: "Australia", region: "Oceania")
        ]
        
        let viewModel = ViewModel(countryService: MockCountryService(result: .success(mockData)))
        let expectation = expectation(description: "Reset country list")
        
        viewModel.downloadCountryData {
            viewModel.filter(by: "Europe")
            XCTAssertEqual(viewModel.countries.count, 1)
            
            viewModel.resetCountries()
            XCTAssertEqual(viewModel.countries.count, 2)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
}
