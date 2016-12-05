//
//  SetlistFmAPI.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 17/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import Foundation

enum Method: String {
    case searchArtists = "search/artists.json"
    case searchSetlist = "search/setlists.json"
    case searchVenues = "search/venues.json"
}

enum SearchArtistsResult {
    case success([SearchedArtist])
    case failure(Error)
}

enum SearchSetlistResult {
    case success(SearchedSetlist)
    case notFound
    case failure(Error)
}

enum SearchVenuesResult {
    case success([SearchedVenue])
    case failure(Error)
}

enum SetlistFmError: Error {
    case invalidJSONData
}

struct SetlistFmAPI {

    private static let baseURL = "https://api.setlist.fm/rest/0.1/"

    internal static func setlistFmURL(method: Method, params: [String:String]?) -> URL {
        var components = URLComponents(string: baseURL)!
        components.path += method.rawValue
        var queryItems = [URLQueryItem]()

        if let params = params {
            for (k,v) in params {
                queryItems.append(URLQueryItem(name: k, value: v))
            }
        }
        components.queryItems = queryItems

        return components.url!
    }
}
