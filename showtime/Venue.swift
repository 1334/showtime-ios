//
//  Venue.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 27/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import CoreData

@objc(Venue)
class Venue: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var concerts: [Concert]

    override var description: String { return name }
}

extension Venue {
    convenience init(from searchedVenue: SearchedVenue) {
        self.init(context: CoreDataHelpers.viewContext)
    }
}

extension Venue: NamedManagedObjectType {
    static var entityName: String {
        return "Venue"
    }

    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "name", ascending: true)]
    }
}
