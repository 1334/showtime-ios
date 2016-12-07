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
    @NSManaged var setlist: String?
    @NSManaged var setlistUpdatedAt: Date?

    var formattedDate: String  {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df.string(from: date)
    }

    var setlistText: String {
        guard let setlist = setlist, let setlistUpdatedAt = setlistUpdatedAt else { return "No setlist" }
        return "\(setlist)\n\n updated at: \(setlistUpdatedAt)"
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

    static func recent(limit:Int = 5) -> [Concert] {
        let request = sortedFetchRequest

        request.predicate = NSPredicate(format: "date < %@", argumentArray: [Date.yesterday])
        request.fetchLimit = limit
        return (try? CoreDataHelpers.viewContext.fetch(request)) ?? []
    }

    static func upcoming(limit:Int = 5) -> [Concert] {
        let request = sortedFetchRequest
        request.predicate = NSPredicate(format: "date >= %@", argumentArray: [Date.yesterday])
        request.fetchLimit = limit
        return (try? CoreDataHelpers.viewContext.fetch(request)) ?? []
    }
}
