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

enum SearchArtistsResult {
    case success([SearchedArtist])
    case failure(Error)
}

enum SetlistFmError: Error {
    case invalidJSONData
}

struct SetlistFmAPI {

    static func searchArtistsURL(keyword: String) -> URL {
        return setlistFmURL(method: .searchArtists, params: ["artistName": keyword])
    }

    static func artistsFromJSON(data: Data) -> SearchArtistsResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonDict = jsonObject as? [String:Any],
                let artistsDict = jsonDict["artists"] as? [String:Any],
                let artistsArray = artistsDict["artist"] as? [[String:String]]
                else { return .failure(SetlistFmError.invalidJSONData) }

            var artists = [SearchedArtist]()
            for artist in artistsArray {
                if let artist = artistFrom(json: artist) {
                    artists.append(artist)
                }
            }

            if artists.count == 0 && artistsArray.count > 0 {
                return .failure(SetlistFmError.invalidJSONData)
            }

            return .success(artists)
        } catch let error {
            return .failure(error)
        }
    }

    // MARK: private section
    private static let baseURL = "https://api.setlist.fm/rest/0.1/"

    private static func setlistFmURL(method: Method, params: [String:String]?) -> URL {
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

    private static func artistFrom(json: [String:String]) -> SearchedArtist? {
        guard let mbid = json["@mbid"],
            let name = json["@name"]
            else { return nil }
        return SearchedArtist(mbid: mbid, name: name, sortName: json["@sortName"], disambiguation: json["@disambiguation"])
    }
}
