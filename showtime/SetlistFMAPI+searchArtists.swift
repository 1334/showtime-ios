//
//  SetlistFMAPI+searchArtists.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 29/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import Foundation

extension SetlistFmAPI {
    static func searchArtistsURL(keyword: String, pageNumber: Int = 1) -> URL {
        return setlistFmURL(method: .searchArtists, params: ["artistName": keyword, "p":"\(pageNumber)"])
    }

    static func artistsFromJSON(data: Data) -> SearchArtistsResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonDict = jsonObject as? [String:Any],
                let artistsDict = jsonDict["artists"] as? [String:Any]
                else { return .failure(SetlistFmError.invalidJSONData) }

            // API returns an array with multiple results or a single element without an array
            var artistsArray = [[String:String]]()
            if let artists = artistsDict["artist"] as? [[String:String]] {
                artistsArray.append(contentsOf: artists)
            }
            if let artist = artistsDict["artist"] as? [String:String] {
                artistsArray.append(artist)
            }

            let artists:[SearchedArtist] = artistsArray.flatMap { artist in
                if let result = artistFrom(json: artist) {
                    return result
                }
                return nil
            }

            if artists.count == 0 && artistsArray.count > 0 {
                return .failure(SetlistFmError.invalidJSONData)
            }

            return .success(artists)
        } catch let error {
            return .failure(error)
        }
    }

    private static func artistFrom(json: [String:String]) -> SearchedArtist? {
        guard let mbid = json["@mbid"],
            let name = json["@name"]
            else { return nil }
        return SearchedArtist(mbid: mbid, name: name, sortName: json["@sortName"], disambiguation: json["@disambiguation"])
    }
}
