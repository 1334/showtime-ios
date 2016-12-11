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

    override var description: String { return name }
}

extension Country: NamedManagedObjectType {
    static var entityName: String {
        return "Country"
    }
}
