//
//  SetlistFMAPI+searchVenues.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 29/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import Foundation

extension SetlistFmAPI {
    static func searchVenuesURL(keyword: String) -> URL {
        return setlistFmURL(method: .searchVenues, params: ["name": keyword])
    }

    static func venuesFromJSON(data: Data) -> SearchVenuesResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonDict = jsonObject as? [String:Any],
                let venuesDict = jsonDict["venues"] as? [String:Any]
                else { return .failure(SetlistFmError.invalidJSONData) }

            // API returns an array with multiple results or a single element without an array
            var venuesArray = [[String:Any]]()
            if let venues = venuesDict["venue"] as? [[String:Any]] {
                venuesArray.append(contentsOf: venues)
            }
            if let venue = venuesDict["venue"] as? [String:Any] {
                venuesArray.append(venue)
            }

            let venues:[SearchedVenue] = venuesArray.flatMap { venue in
                if let result = venueFrom(json: venue) {
                    return result
                }
                return nil
            }

            if venues.count == 0 && venuesArray.count > 0 {
                return .failure(SetlistFmError.invalidJSONData)
            }

            return .success(venues)
        } catch let error {
            return .failure(error)
        }
    }

    private static func venueFrom(json: [String:Any]) -> SearchedVenue? {
        guard let setlistId = json["@id"] as? String,
            let name = json["@name"] as? String,
            let city = json["city"] as? [String:Any],
            let country = city["country"] as? [String:Any],
            let cityId = city["@id"] as? String,
            let cityName = city["@name"] as? String,
            let coords = city["coords"] as? [String:String],
            let latitude = coords["@lat"],
            let longitude = coords["@long"],
            let countryName = country["@name"] as? String
        else { return nil }

        return SearchedVenue(setlistId: setlistId, name: name, cityId: cityId, cityName: cityName, country: countryName, latitude: Double(latitude)!, longitude: Double(longitude)!)
    }
}
