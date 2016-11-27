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

    override var description: String { return "\(artist) live at \(venue) on \(formattedDate)" }
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
    var formattedDate: String  {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df.string(from: date)
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
