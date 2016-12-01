//
//  City.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 01/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import CoreData

@objc(City)
class City: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var country: Country
    @NSManaged var venues: [Venue]
}

extension City: ManagedObjectType {
    static var entityName: String {
        return "City"
    }

    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "name", ascending: true)]
    }
}
