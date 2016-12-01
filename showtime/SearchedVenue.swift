//
//  SearchedVenue.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 29/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import Foundation

struct SearchedVenue {
    let id: String
    let name: String
    let cityId: String
    let cityName: String
    let countryName: String
    let countryCode: String
    let latitude: Double
    let longitude: Double

    var location: String {
        return [cityName, countryName].joined(separator: ", ")
    }
}
