//
//  Concert.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 27/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit
import CoreData

@objc(Concert)
class Concert: NSManagedObject {

    @NSManaged var artist: Artist
    @NSManaged var date: Date
    @NSManaged var venue: Venue
    @NSManaged var notes: String?
    @NSManaged var setlist: String?
    @NSManaged var setlistUpdatedAt: Date?
    @NSManaged var storedImage: UIImage?

    var image: UIImage {
        return storedImage ?? #imageLiteral(resourceName: "concertPlaceHolder")
    }

    var formattedDate: String  {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df.string(from: date)
    }

    var setlistText: String {
        guard let setlist = setlist else { return "setlist not found" }

        return setlist
    }

    override var description: String {
        return "\(artist) live at \(venue) on \(formattedDate)"
    }

    func updateSetlist(_ setlist: SearchedSetlist) {
        self.setlist = setlist.setlist.map { $0.joined(separator: "\n") }.joined(separator: "\n\n")
        self.setlistUpdatedAt = setlist.updatedAt
        managedObjectContext?.saveIt()
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
    static func from(artist: String, date: String, venue: String, dateParser:DateFormatter = DateFormatters.dateParser) -> Concert {
        let artist = Artist.named(artist)
        let venue = Venue.named(venue)
        let date = dateParser.date(from: date)!

        let predicate = NSPredicate(format: "artist == %@ AND date == %@", artist, date as NSDate)
        let result = Concert.find(predicate: predicate)

        if let concert = result.first {
            concert.venue = venue
            return concert
        } else {
            let concert = Concert(context: CoreDataStack.viewContext)
            concert.artist = artist
            concert.venue = venue
            concert.date = date

            return concert
        }
    }
}

extension Concert {
    static func predicateMatching(keyword: String) -> NSPredicate {
        return NSPredicate(format: "artist.name CONTAINS[cd] %@ OR venue.name CONTAINS[cd] %@", keyword, keyword)
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
        return (try? CoreDataStack.viewContext.fetch(request)) ?? []
    }

    static func upcoming(limit:Int = 5) -> [Concert] {
        let request = sortedFetchRequest
        request.predicate = NSPredicate(format: "date >= %@", argumentArray: [Date.yesterday])
        request.fetchLimit = limit
        return (try? CoreDataStack.viewContext.fetch(request)) ?? []
    }
}
