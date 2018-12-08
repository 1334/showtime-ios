//
//  SetlistFMAPITests.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 26/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import XCTest
@testable import showtime

class SetlistFMAPITests: XCTestCase {
    func testSearchingForArtists_GeneratesTheCorrectURL() {
        let searchTerm = "nick cave"
        let expectedURL = URLComponents(string: "https://api.setlist.fm/rest/0.1/search/artists.json?artistName=nick%20cave")!
        let url = URLComponents(url: SetlistFmAPI.searchArtistsURL(keyword: searchTerm), resolvingAgainstBaseURL: false)!

        XCTAssertEqual(expectedURL.host, url.host)
        for item in expectedURL.queryItems! {
            XCTAssert(url.queryItems!.contains(item), "\(url.queryItems!) expected to include \(item)")
        }
    }

    func testSearchingForVenues_GeneratesTheCorrectURL() {
        let searchTerm = "estadi olimpic"
        let expectedURL = URLComponents(string: "https://api.setlist.fm/rest/0.1/search/venues.json?name=estadi%20olimpic")!
        let url = URLComponents(url: SetlistFmAPI.searchVenuesURL(keyword: searchTerm), resolvingAgainstBaseURL: false)!

        XCTAssertEqual(expectedURL.host, url.host)
        for item in expectedURL.queryItems! {
            XCTAssert(url.queryItems!.contains(item), "\(url.queryItems!) expected to include \(item)")
        }
    }

    func testSearchingForSetlists_GeneratesTheCorrectURL() {
        let artist = "and one"
        let venue = "bikini"
        let stringDate = "30-09-2016"
        let date = DateFormatters.dateParser.date(from: stringDate)!
        
        let expectedURL = URLComponents(string: "https://api.setlist.fm/rest/0.1/search/setlists.json?artistName=and%20one&venueName=bikini&date=30-09-2016")!
        let url = URLComponents(url: SetlistFmAPI.searchSetlistURL(artist: artist, venue: venue, date: date), resolvingAgainstBaseURL: false)!

        XCTAssertEqual(expectedURL.host, url.host)
        for item in expectedURL.queryItems! {
            XCTAssert(url.queryItems!.contains(item), "\(url.queryItems!) expected to include \(item)")
        }
    }

}
