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
}

enum SearchArtistsResult {
    case success([SearchedArtist])
    case failure(Error)
}

enum SearchSetlistResult {
    case success([[String]])
    case notFound
    case failure(Error)
}

enum SetlistFmError: Error {
    case invalidJSONData
}

struct SetlistFmAPI {

    // MARK: Searching artists
    static func searchArtistsURL(keyword: String) -> URL {
        return setlistFmURL(method: .searchArtists, params: ["artistName": keyword])
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

    static func mbidFor(artist: String) {
        SetlistFmStore().searchArtists(keyword: artist) { result in
            switch result {
            case let .success(artists):
                let matchingArtists = artists.filter { return artist.lowercased() == $0.name.lowercased() }
                if matchingArtists.count == 1 {
                    print("mbid found for \(matchingArtists.first!.name): \(matchingArtists.first!.mbid)")
                } else {
                    print("ambiguous result for \(matchingArtists.first!.name), more than one match found")
                }
            case .failure:
                print("no mbid found")
            }
        }
    }

    static func searchSetlist(data: Data) -> SearchSetlistResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard let root = jsonObject as? [String:Any],
                let setlists = root["setlists"] as? [String:Any],
                let setlist = setlists["setlist"] as? [String:Any],
                let sets = setlist["sets"] as? [String:Any],
                let set = sets["set"] as? [[String:Any]]
                else { return .failure(SetlistFmError.invalidJSONData) }

            let completeSetlist: [[String]] = set.map { setPart in
                guard let songs = setPart["song"] as? [[String:Any]] else { return [] }

                return songs.map { $0["@name"] as! String }
            }

            return .success(completeSetlist)

        } catch let error {
            return .failure(error)
        }
    }

    // MARK: searching setlists
    static func searchSetlistURL(artist: String, venue: String, date: String) -> URL {
        return setlistFmURL(method: .searchSetlist, params: ["artistName": artist, "venueName": venue, "date": date])
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
