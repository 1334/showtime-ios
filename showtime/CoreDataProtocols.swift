//
//  CoreDataProtocols.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 12/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import CoreData

protocol ManagedObjectType {
    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
    static var defaultPredicate: NSPredicate { get }
}

extension ManagedObjectType where Self: NSManagedObject {
    static var defaultSortDescriptors : [NSSortDescriptor] {
        return []
    }

    static var defaultPredicate: NSPredicate {
        return NSPredicate(value: true)
    }

    static var sortedFetchRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        request.predicate = defaultPredicate
        return request
    }

    static func all() -> [Self] {
        let request = Self.sortedFetchRequest
        return (try? CoreDataHelpers.viewContext.fetch(request)) ?? []
    }
}
