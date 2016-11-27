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
