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
                let expectedURL = "https://api.setlist.fm/rest/0.1/search/artists.json?artistName=nick%20cave"
                let url = "\(SetlistFmAPI.searchArtistsURL(keyword: searchTerm))"

                expect(url).to(equal(expectedURL))
            }
        }
    }
}
