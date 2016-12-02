//
//  ConcertScope.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 02/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import CoreData

enum ConcertScope {
    case all
    case artist(Artist)
    case venue(Venue)

    var predicate: NSPredicate {
        switch self {
        case .all:
            return Concert.defaultPredicate
        case .artist(let artist):
            return Concert.predicateFilteredBy(artist: artist)
        case .venue(let venue):
            return Concert.predicateFilteredBy(venue: venue)
        }
    }
}
