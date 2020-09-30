//
//  Covid19Model.swift
//  Books
//
//  Created by Dang Duy Cuong on 9/30/20.
//  Copyright © 2020 Dang Duy Cuong. All rights reserved.
//

import UIKit

struct Covid19Model: Codable {
    var country: String?
    var countryInfo: CountryInfoModel?
    
    var cases: Int?
    var todayCases: Int?
    var deaths: Int?
    var todayDeaths: Int?

    var recovered: Int?
    var todayRecovered: Int?
}

struct CountryInfoModel: Codable {
    var flag: String?
}
