//
//  ManagedObjectType.swift
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
        request.sortDescriptors = self.defaultSortDescriptors
        request.predicate = self.defaultPredicate
        return request
    }

    static func all() -> [Self] {
        let request = Self.sortedFetchRequest
        return (try? CoreDataStack.viewContext.fetch(request)) ?? []
    }

    static func find(predicate:NSPredicate) -> [Self] {
        let request = Self.sortedFetchRequest
        request.predicate = predicate
        return (try? CoreDataStack.viewContext.fetch(request)) ?? []
    }
}
