//
//  CoreDataHelpers.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 10/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHelpers {
    static var container: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.container
    }()

    static var viewContext: NSManagedObjectContext = {
        return container.viewContext
    }()
}

extension NSManagedObjectContext {
    func saveIt() {
        if hasChanges {
            do {
                try save()
            } catch {
                fatalError("Error saving \(self.description) context! \(error)")
            }
        }
    }
}
