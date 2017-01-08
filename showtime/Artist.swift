//
//  Artist.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 27/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit
import CoreData

@objc(Artist)
class Artist: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var mbid: String?
    @NSManaged var sortName: String
    @NSManaged var concerts: [Concert]
    @NSManaged var storedImage: UIImage?

    var image: UIImage {
        return storedImage ?? #imageLiteral(resourceName: "artistPlaceHolder")
    }

    override var description: String { return name }

    enum Scope {
        case all
        case matching(String)

        var predicate: NSPredicate {
            switch self {
            case .all:
                return Concert.defaultPredicate
            case .matching(let term):
                return NSPredicate(format: "name CONTAINS[cd] %@", term)
            }
        }
    }
}

extension Artist {
    func update(from searchedArtist: SearchedArtist) {
        name = searchedArtist.name
        mbid = searchedArtist.mbid
        sortName = searchedArtist.sortName ?? searchedArtist.name
    }

    convenience init(mbid: String, name: String, image: UIImage? = nil, sortName: String? = nil) {
        self.init(context: CoreDataStack.viewContext)
        self.name = name
        self.mbid = mbid
        self.storedImage = image
        self.sortName = sortName ?? name
    }
}

extension Artist: NamedManagedObjectType {
    static var entityName: String {
        return "Artist"
    }

    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "sortName", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare))]
    }
}
