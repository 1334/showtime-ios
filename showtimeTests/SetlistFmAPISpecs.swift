//
//  SetlistFmAPISpecs.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 17/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import Quick
import Nimble
@testable import showtime

class SetlistFmAPISpecs: QuickSpec {
    override func spec() {
        describe("searching for artists") {
            it("generates the correct URL") {
                let searchTerm = "nick cave"
                let expectedURL = URLComponents(string: "https://api.setlist.fm/rest/0.1/search/artists.json?artistName=nick%20cave")!
                let url = URLComponents(url: SetlistFmAPI.searchArtistsURL(keyword: searchTerm), resolvingAgainstBaseURL: false)!

                expect(url.host).to(equal(expectedURL.host))
                expect(url.queryItems).to(contain(expectedURL.queryItems!))
            }
        }
        describe("searching for setlists") {
            it("generates the correct URL") {
                let artist = "and one"
                let venue = "bikini"
                let date = "30-09-2016"
                let expectedURL = URLComponents(string: "https://api.setlist.fm/rest/0.1/search/setlists.json?artistName=and%20one&venueName=bikini&date=30-09-2016")!
                let url = URLComponents(url: SetlistFmAPI.searchSetlistURL(artist: artist, venue: venue, date: date), resolvingAgainstBaseURL: false)!

                expect(url.host).to(equal(expectedURL.host))
                expect(url.queryItems).to(contain(expectedURL.queryItems!))
            }
        }
    }
}
