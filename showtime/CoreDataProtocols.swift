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

    static func find(predicate:NSPredicate) -> [Self] {
        let request = Self.sortedFetchRequest
        request.predicate = predicate
        return (try? CoreDataHelpers.viewContext.fetch(request)) ?? []
    }
}

protocol NamedManagedObjectType : ManagedObjectType {
    var name: String { get set }
}

extension NamedManagedObjectType where Self : NSManagedObject {
    static func named(_ name: String, context: NSManagedObjectContext = CoreDataHelpers.viewContext) -> Self {
        let predicate = NSPredicate(format: "name =[cd] %@", name)
        let result = Self.find(predicate: predicate).first
        if let result = result {
            return result
        } else {
            var newItem = Self(context: context)
            newItem.name = name
            return newItem
        }
    }
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare))]
    }
}
