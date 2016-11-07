//
//  Models.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 07/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

// MARK: Concert
struct Concert: CustomStringConvertible {
    let artist: Artist
    let date: Date
    let venue: Venue

    var description: String { return "\(artist) live at \(venue) on \(formattedDate))" }
}

extension Concert {
    var formattedDate: String  {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df.string(from: date)
    }
}
extension Concert {
    init(artist: String, date: String, venue: String, dateParser:DateFormatter = DateFormatters.dateParser ) {
        self.artist = Artist(name: artist)
        self.date = dateParser.date(from: date)!
        self.venue = Venue(name: venue)
    }
}

// MARK: Artist
struct Artist: CustomStringConvertible {
    let name: String

    var description: String { return name }
}

// MARK: Venue
struct Venue: CustomStringConvertible {
    let name: String

    var description: String { return name }
}
