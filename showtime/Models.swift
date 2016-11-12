//
//  Models.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 07/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit
import CoreData

// MARK: Concert
@objc(Concert)
class Concert: NSManagedObject {
    
    @NSManaged var artist: Artist
    @NSManaged var date: Date
    @NSManaged var venue: Venue

    override var description: String { return "\(artist) live at \(venue) on \(formattedDate)" }
}

extension Concert {
    var formattedDate: String  {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df.string(from: date)
    }
}
//extension Concert {
//    convenience init(artist: String, date: String, venue: String, dateParser:DateFormatter = DateFormatters.dateParser ) {
//        self.artist = Artist(name: artist)
//        self.date = dateParser.date(from: date)!
//        self.venue = Venue(name: venue)
//    }
//}

// MARK: Artist
@objc(Artist)
class Artist: NSManagedObject {
    @NSManaged var name: String

    override var description: String { return name }
}

// MARK: Venue
@objc(Venue)
class Venue: NSManagedObject {
    @NSManaged var name: String

    override var description: String { return name }
}
