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
}

struct SetlistFmAPI {

    static func searchArtistsURL(keyword: String) -> URL {
        return setlistFmURL(method: .searchArtists, params: ["artistName": keyword])
    }

    // MARK: private section
    private static let baseURL = "https://api.setlist.fm/rest/0.1"

    private static func setlistFmURL(method: Method, params: [String:String]?) -> URL {
        var components = URLComponents(string: baseURL)!
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
