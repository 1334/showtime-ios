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
    @NSManaged var concerts: [Concert]
    @NSManaged var storedImage: UIImage?

    var image: UIImage {
        return storedImage ?? #imageLiteral(resourceName: "artistPlaceHolder")
    }

    override var description: String { return name }
}

extension Artist {
    func update(from searchedArtist: SearchedArtist) {
        name = searchedArtist.name
        mbid = searchedArtist.mbid
    }

    convenience init(mbid: String, name: String) {
        self.init(context: CoreDataHelpers.viewContext)
        self.name = name
        self.mbid = mbid
    }

    static func predicateMatching(keyword: String) -> NSPredicate {
        return NSPredicate(format: "name CONTAINS[cd] %@", keyword)
    }
}

extension Artist: NamedManagedObjectType {
    static var entityName: String {
        return "Artist"
    }

    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "name", ascending: true)]
    }
}
