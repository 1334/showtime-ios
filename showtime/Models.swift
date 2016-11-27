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

// MARK: Artist
@objc(Artist)
class Artist: NSManagedObject {
    @NSManaged var name: String

    override var description: String { return name }
}

extension Artist: NamedManagedObjectType {
    static var entityName: String {
        return "Artist"
    }

    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "name", ascending: true)]
    }
}


// MARK: Venue
@objc(Venue)
class Venue: NSManagedObject {
    @NSManaged var name: String

    override var description: String { return name }
}

extension Venue: NamedManagedObjectType {
    static var entityName: String {
        return "Venue"
    }

    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "name", ascending: true)]
    }
}
