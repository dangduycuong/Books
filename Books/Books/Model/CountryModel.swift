//
//  CountryModel.swift
//  Books
//
//  Created by Dang Duy Cuong on 9/30/20.
//  Copyright © 2020 Dang Duy Cuong. All rights reserved.
//

import Foundation

struct CountryModel: Codable {
    var updated: Double?
    var country: String?
    var countryInfo: CountryInfo?
    var cases: Int?
    
    var todayCases: Int?
    var deaths: Int?
    var todayDeaths: Int?
    var recovered: Int?
    
    var todayRecovered: Int?
    var active: Int?
    var critical: Int?
    var casesPerOneMillion: Int?
    
    var deathsPerOneMillion: Int?
    var tests: Int?
    var testsPerOneMillion: Int?
    var population: Int?
    
    var continent: String?
    var oneCasePerPeople: Int?
    var oneDeathPerPeople: Int?
    var oneTestPerPeople: Int?
    
    var activePerOneMillion: Double?
    var recoveredPerOneMillion: Double?
    var criticalPerOneMillion: Double?
}

struct CountryInfo: Codable {
    var _id: Int?
    var iso2: String?
    var iso3: String?
    var lat: Double?
    var long: Double?
    var flag: String?
}
