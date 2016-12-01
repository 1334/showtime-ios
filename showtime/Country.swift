//
//  Country.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 01/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import CoreData

@objc(Country)
class Country: NSManagedObject {
    @NSManaged var code: String
    @NSManaged var name: String
    @NSManaged var cities: [City]
}

extension Country: ManagedObjectType {
    static var entityName: String {
        return "Country"
    }

    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "name", ascending: true)]
    }
}
