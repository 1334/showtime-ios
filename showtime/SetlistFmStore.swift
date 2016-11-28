//
//  SetlistFmStore.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 17/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import Foundation

class SetlistFmStore {
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()

    func searchArtists(keyword: String, completion: @escaping (SearchArtistsResult) -> Void) {
        let url = SetlistFmAPI.searchArtistsURL(keyword: keyword)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            let result = self.processArtistSearch(data: data, error: error)
            completion(result)
        }
        task.resume()
    }

    func processArtistSearch(data: Data?, error: Error?) -> SearchArtistsResult {
        guard let jsonData = data else { return .failure(error!) }

        return SetlistFmAPI.artistsFromJSON(data: jsonData)
    }

    func searchSetlist(artist: String, venue: String, date: String, completion: @escaping (SearchSetlistResult) -> Void) {
//        let dateString = String(describing: date)
        let url = SetlistFmAPI.searchSetlistURL(artist: artist, venue: venue, date: date)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            guard let jsonData = data else { return }

            let result = SetlistFmAPI.searchSetlist(data: jsonData)
            completion(result)
        }
        task.resume()
    }
}
