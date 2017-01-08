//
//  NamedManagedObjectType.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 08/01/2017.
//  Copyright © 2017 UOC. All rights reserved.
//

import CoreData

protocol NamedManagedObjectType : ManagedObjectType {
    var name: String { get set }
}

extension NamedManagedObjectType where Self : NSManagedObject {
    static func named(_ name: String, context: NSManagedObjectContext = CoreDataStack.viewContext) -> Self {
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
