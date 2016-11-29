//
//  Artist.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 27/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import CoreData

@objc(Artist)
class Artist: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var mbid: String?

    override var description: String { return name }
}

extension Artist {
    convenience init(from searchedArtist: SearchedArtist) {
        self.init(context: CoreDataHelpers.viewContext)
        self.name = searchedArtist.name
        self.mbid = searchedArtist.mbid
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
