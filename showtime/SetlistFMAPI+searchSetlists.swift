//
//  SetlistFMAPI+searchSetlists.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 29/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import Foundation

extension SetlistFmAPI {

    static func searchSetlistURL(artist: String, venue: String, date: String) -> URL {
        return setlistFmURL(method: .searchSetlist, params: ["artistName": artist, "venueName": venue, "date": date])
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
    
}
