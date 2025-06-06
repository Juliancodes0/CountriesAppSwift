//
//  Country.swift
//  CountriesAPIUIKit
//
//  Created by Julian Burton on 6/6/25
//

import Foundation

struct Country: Decodable {
    let capital: String
    let name: String
    let region: String
}
