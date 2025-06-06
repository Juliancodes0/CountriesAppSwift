//
//  CountriesAPIUIKitTests.swift
//  CountriesAPIUIKitTests
//
//  Created by Julian 沙 on 1/16/24.
//

import XCTest

final class CountriesAPIUIKitTests: XCTestCase {

    func testDownload () {
        let testExpectedResult = self.expectation(description: "Download was successful")
        NetworkManager.downloadDataFromURLString(urlString: "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json", type: [Country].self) { result in
            switch result {
            case .success(let decoded):
                XCTAssertNotNil(decoded)
            case .failure(let failure):
                XCTFail("Failed \(failure.localizedDescription)")
            }
            testExpectedResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
