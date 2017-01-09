//
//  SetlistFMAPI+searchSetlists.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 29/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import Foundation

extension SetlistFmAPI {

    static func searchSetlistURL(artist: String, venue: String, date: Date) -> URL {
        let stringDate = DateFormatters.searchSetlist.string(from: date)

        return setlistFmURL(method: .searchSetlist, params: ["artistName": artist, "venueName": venue, "date": stringDate])
    }

    static func searchSetlistURL(artist: String, date: Date) -> URL {
        let stringDate = DateFormatters.searchSetlist.string(from: date)

        return setlistFmURL(method: .searchSetlist, params: ["artistName": artist, "date": stringDate])
    }

    static func searchSetlist(data: Data) -> SearchSetlistResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard let root = jsonObject as? [String:Any],
                let setlists = root["setlists"] as? [String:Any],
                let setlist = setlists["setlist"] as? [String:Any],
                let sets = setlist["sets"] as? [String:Any]
                else { return .failure(SetlistFmError.invalidJSONData) }

            guard let updatedAtString = setlist["@lastUpdated"] as? String,
                let updatedAt = DateFormatters.updatedAt.date(from: updatedAtString)
                else { return .failure(SetlistFmError.invalidJSONData) }

            var completeSet = [[String:Any]]()

            // if it has encores [[String:Any]]
            if let set = sets["set"] as? [[String:Any]] {
                completeSet.append(contentsOf: set)
            }

            // if set is a single block, then [String:Any]
            if let set = sets["set"] as? [String:Any] {
                completeSet.append(set)
            }

            let completeSetlist: [[String]] = completeSet.flatMap { setPart in
                guard let songs = setPart["song"] as? [[String:Any]] else { return nil }

                return songs.map { $0["@name"] as! String }
            }

            return .success(SearchedSetlist(setlist: completeSetlist, updatedAt: updatedAt))

        } catch let error {
            return .failure(error)
        }
    }

    private enum DateFormatters {
        static let searchSetlist: DateFormatter = {
            let df = DateFormatter()
            df.dateFormat = "dd-MM-yyyy"

            return df
        }()
        static let updatedAt: DateFormatter = {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"

            return df
        }()
    }
    
}
