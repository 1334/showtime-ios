//
//  Concert.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 27/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import CoreData

@objc(Concert)
class Concert: NSManagedObject {

    @NSManaged var artist: Artist
    @NSManaged var date: Date
    @NSManaged var venue: Venue
    @NSManaged var notes: String?

    var formattedDate: String  {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df.string(from: date)
    }

    override var description: String {
        return "\(artist) live at \(venue) on \(formattedDate)"
    }
}

extension Concert: ManagedObjectType {
    static var entityName: String {
        return "Concert"
    }

    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "date", ascending: false)]
    }
}

extension Concert {
    convenience init(artist: String, date: String, venue: String, dateParser:DateFormatter = DateFormatters.dateParser ) {
        self.init(context: CoreDataHelpers.viewContext)

        self.artist = Artist.named(artist)
        self.date = dateParser.date(from: date)!
        self.venue = Venue.named(venue)
    }
}

extension Concert {
    static func predicateMatching(keyword: String) -> NSPredicate {
        return NSPredicate(format: "artist.name CONTAINS[c] %@ OR venue.name CONTAINS[c] %@", keyword, keyword)
    }

    static func predicateFilteredBy(artist: Artist) -> NSPredicate {
        return NSPredicate(format: "artist == %@", artist)
    }

    static func predicateFilteredBy(venue: Venue) -> NSPredicate {
        return NSPredicate(format: "venue == %@", venue)
    }
}
