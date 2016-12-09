//
//  Venue.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 27/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import CoreData
import MapKit

@objc(Venue)
class Venue: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var city: City
    @NSManaged var concerts: [Concert]

    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
            managedObjectContext?.saveIt()
        }
    }

    func updateCoords() {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "\(name), \(city.name)"
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else { return }
            for item in response.mapItems {
                let foundName = item.placemark.addressDictionary?["Name"] as? String ?? ""
                let foundCity = item.placemark.addressDictionary?["City"] as? String ?? ""
                if foundName.lowercased().contains(self.name.lowercased()) && foundCity.lowercased().contains(self.city.name.lowercased()) {
                    self.coordinate = item.placemark.coordinate
                    self.managedObjectContext?.saveIt()
                }
            }
        }
    }

    override var description: String { return name }
}

extension Venue {
    func update(from searchedVenue: SearchedVenue) {
        self.id = searchedVenue.id
        self.name = searchedVenue.name
        self.latitude = searchedVenue.latitude
        self.longitude = searchedVenue.longitude
        let country = Country.named(searchedVenue.name)
        country.code = searchedVenue.countryCode
        let city = City.named(searchedVenue.cityName)
        city.id = searchedVenue.cityId
        city.country = country
        self.city = city
    }
}

extension Venue: NamedManagedObjectType {
    static var entityName: String {
        return "Venue"
    }

    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "name", ascending: true)]
    }
}

extension Venue: MKAnnotation {
    var title: String? {
        return self.name
    }
    var subtitle: String? {
        return ("\(concerts.count) concerts")
    }

}
