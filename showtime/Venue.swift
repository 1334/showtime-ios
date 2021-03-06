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
    convenience init(id: String, name: String, latitude: Double, longitude: Double, cityId: String, cityName: String, countryCode: String, countryName: String) {
        self.init(context: CoreDataStack.viewContext)
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        let country = Country.named(countryName)
        country.code = countryCode
        let city = City.named(cityName)
        city.id = cityId
        city.country = country
        self.city = city
    }

    func update(from searchedVenue: SearchedVenue) {
        self.id = searchedVenue.id
        self.name = searchedVenue.name
        self.latitude = searchedVenue.latitude
        self.longitude = searchedVenue.longitude
        let country = Country.named(searchedVenue.countryName)
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
}

extension Venue: MKAnnotation {
    var title: String? {
        return self.name
    }
    var subtitle: String? {
        return ("\(concerts.count) concerts")
    }

}
