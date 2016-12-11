//
//  NewDialog.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 08/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

final class FirstRun {
    let context = CoreDataHelpers.viewContext

    func dialog(presenter: UIViewController, callback: @escaping () -> ()) {
        if !UserDefaults.standard.bool(forKey: "FirstRunComplete") {
            let alert = firstRunMessage(callback: callback)
            presenter.present(alert, animated: true)
            UserDefaults.standard.set(true, forKey: "FirstRunComplete")
        }
    }

    private func firstRunMessage(callback: @escaping () -> ()) -> UIAlertController {
        let alert = UIAlertController(title: "New Run", message: "We've found that there are no shows entered, what do you want to do?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Load Sample Data", style: .default) { _ in
            self.createArtists()
            self.createVenues()
            self.createConcerts()
            self.context.saveIt()
            callback()
        })
        alert.addAction(UIAlertAction(title: "Add Concert", style: .default) { _ in
            guard let rootVC = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController else { return }
            rootVC.selectedIndex = 4
            callback()
        })
        alert.addAction(UIAlertAction(title: "Nothing", style: .cancel, handler: nil))

        return alert
    }

    struct FRArtist {
        let mbid: String
        let name: String
    }

    private func createArtists() {
        _ = Artist(mbid: "5441c29d-3602-4898-b1a1-b77fa23b8e50", name: "David Bowie")
        _ = Artist(mbid: "f37b3f31-b1f8-4b88-8cb5-b34f709b17d7", name: "Iggy Pop")
        _ = Artist(mbid: "1253e5e9-eaa7-4ce6-81b8-09725e8cee43", name: "Iggy and the Stooges")
        _ = Artist(mbid: "b7ffd2af-418f-4be2-bdd1-22f8b48613da", name: "Nine Inch Nails")
        _ = Artist(mbid: "3580a118-49e3-4aa1-972a-f5f0ff750dd2", name: "Alien Sex Fiend")
        _ = Artist(mbid: "e5db18cb-4b1f-496d-a308-548b611090d3", name: "Sex Pistols")
        _ = Artist(mbid: "4d7928cd-7ed2-4282-8c29-c0c9f966f1bd", name: "Alice Cooper")
        _ = Artist(mbid: "", name: "Ghost")
        _ = Artist(mbid: "9b7130d0-558a-4599-b721-04b68c43aaad", name: "Jarboe")
        _ = Artist(mbid: "8d936df1-9da6-4b11-87c3-7bb8fd8a62c4", name: "Michael Gira")
        _ = Artist(mbid: "3285dc48-9505-469d-ad8a-bdf2d3dba632", name: "Swans")
        _ = Artist(mbid: "172e1f1a-504d-4488-b053-6344ba63e6d0", name: "Nick Cave & The Bad Seeds")
        _ = Artist(mbid: "b78346af-e3ce-4b36-a0d5-032414de8a27", name: "Peter Murphy")
        _ = Artist(mbid: "0688add2-c282-4ee2-ba61-223ffdb3c201", name: "Bauhaus")
        _ = Artist(mbid: "32981181-5e3f-4160-a872-625980035593", name: "Éliane Radigue")
        _ = Artist(mbid: "1fe4e038-d219-46b0-bb52-286ffd994ee3", name: "Mohammad")
        _ = Artist(mbid: "8a399a51-6b93-448e-82c0-f86c83602605", name: "Hildur Guðnadóttir")
    }

    private func createVenues() {
        _ = Venue(id: "bd6312e", name: "Finsbury Park", latitude: 51.5650636, longitude: -0.0976285,  cityId: "2643743", cityName: "London", countryCode: "GB", countryName: "United Kingdom")
        _ = Venue(id: "7bd72e60", name: "Zeleste", latitude: 41.3887868890716, longitude: 2.15898513793945,  cityId: "3128760", cityName: "Barcelona", countryCode: "ES", countryName: "Spain")
        _ = Venue(id: "1bd635fc", name: "Parc del Fòrum", latitude: 41.3887868890716, longitude: 2.15898513793945,  cityId: "3128760", cityName: "Barcelona", countryCode: "ES", countryName: "Spain")
        _ = Venue(id: "4bd6376a", name: "Razzmatazz", latitude: 41.3977201851836, longitude: 2.1910870223259,  cityId: "3128760", cityName: "Barcelona", countryCode: "ES", countryName: "Spain")
        _ = Venue(id: "4bd6c356", name: "Pavelló de la Vall d’Hebron", latitude: 41.3887868890716, longitude: 2.15898513793945,  cityId: "3128760", cityName: "Barcelona", countryCode: "ES", countryName: "Spain")
        _ = Venue(id: "63d6367b", name: "Palau Sant Jordi", latitude: 41.3633907072884, longitude: 2.15266853570938,  cityId: "3128760", cityName: "Barcelona", countryCode: "ES", countryName: "Spain")
        _ = Venue(id: "4bd71b36", name: "Sant Jordi Club", latitude: 41.3887868890716, longitude: 2.15898513793945,  cityId: "3128760", cityName: "Barcelona", countryCode: "ES", countryName: "Spain")
        _ = Venue(id: "4bd5bba2", name: "El Born Centre Cultural", latitude: 41.3858229559798, longitude: 2.18384972824424,  cityId: "3128760", cityName: "Barcelona", countryCode: "ES", countryName: "Spain")
        _ = Venue(id: "73d4168d", name: "Teatre del Casino", latitude: 41.9301237335047, longitude: 2.25485801696777,  cityId: "3106050", cityName: "Vic", countryCode: "ES", countryName: "Spain")
        _ = Venue(id: "63d45e7b", name: "Auditori de l'Ateneu", latitude: 42.1166667, longitude: 2.7666667,  cityId: "3128885", cityName: "Banyoles", countryCode: "ES", countryName: "Spain")
        _ = Venue(id: "33d61cfd", name: "Sala Becool", latitude: 41.3887868890716, longitude: 2.15898513793945,  cityId: "3128760", cityName: "Barcelona", countryCode: "ES", countryName: "Spain")
        _ = Venue(id: "5bd7b74c", name: "La [2] de Apolo", latitude: 41.3887868890716, longitude: 2.15898513793945,  cityId: "3128760", cityName: "Barcelona", countryCode: "ES", countryName: "Spain")
        _ = Venue(id: "3d61d8b", name: "Sala Apolo", latitude: 41.374278662964, longitude: 2.16956508585507,  cityId: "3128760", cityName: "Barcelona", countryCode: "ES", countryName: "Spain")
        _ = Venue(id: "23d5882b", name: "Auditori CCIB", latitude: 41.3887868890716, longitude: 2.15898513793945,  cityId: "3128760", cityName: "Barcelona", countryCode: "ES", countryName: "Spain")
        _ = Venue(id: "3d61d83", name: "La Riviera", latitude: 40.4051136033285, longitude: -3.62879424791064,  cityId: "3117735", cityName: "Madrid", countryCode: "ES", countryName: "Spain")
        _ = Venue(id: "7bd7ea60", name: "El Pla de Santa Maria", latitude: 42.6166667, longitude: 1.1333333,  cityId: "3123031", cityName: "Escalarre", countryCode: "ES", countryName: "Spain")
        _ = Venue(id: "4bd61f3e", name: "Irving Plaza", latitude: 40.7349348, longitude: -73.9884569,  cityId: "5128581", cityName: "New York", countryCode: "US", countryName: "United States")
        _ = Venue(id: "53d63779", name: "Royal Albert Hall", latitude: 51.5010389760603, longitude: -0.177273502134961,  cityId: "2643743", cityName: "London", countryCode: "GB", countryName: "United Kingdom")
        _ = Venue(id: "5bd4b3cc", name: "Estadi Olímpic Lluís Companys", latitude: 41.3647687, longitude: 2.1534705, cityId: "3128760", cityName: "Barcelona", countryCode: "ES", countryName: "Spain")
        _ = Venue(id: "53d50701", name: "Pavelló Olímpic de Badalona", latitude: 41.4500446631785, longitude: 2.24741220474243, cityId: "3129028", cityName: "Badalona", countryCode: "ES", countryName: "Spain")
    }

    private func createConcerts() {
        _ = Concert.from(artist: "David Bowie", date: "16-09-1990", venue: "Estadi Olímpic Lluís Companys")
        _ = Concert.from(artist: "Iggy Pop", date: "23-06-1996", venue: "Finsbury Park")
        _ = Concert.from(artist: "Iggy Pop", date: "30-10-1993", venue: "Zeleste")
        _ = Concert.from(artist: "Iggy and the Stooges", date: "6-07-2012", venue: "Parc del Fòrum")
        _ = Concert.from(artist: "Iggy Pop", date: "18-11-1999", venue: "Zeleste")
        _ = Concert.from(artist: "Iggy Pop", date: "27-04-1994", venue: "Zeleste")
        _ = Concert.from(artist: "Nine Inch Nails", date: "29-06-2005", venue: "Razzmatazz")
        _ = Concert.from(artist: "Nine Inch Nails", date: "14-11-1999", venue: "Pavelló de la Vall d’Hebron")
        _ = Concert.from(artist: "Nine Inch Nails", date: "31-05-2014", venue: "Parc del Fòrum")
        _ = Concert.from(artist: "Nine Inch Nails", date: "18-02-2007", venue: "Razzmatazz")
        _ = Concert.from(artist: "Sex Pistols", date: "19-07-2008", venue: "Parc del Fòrum")
        _ = Concert.from(artist: "Sex Pistols", date: "23-06-1996", venue: "Finsbury Park")
        _ = Concert.from(artist: "Alice Cooper", date: "11-12-2002", venue: "Palau Sant Jordi")
        _ = Concert.from(artist: "Kitsch a la Cova", date: "13-05-2016", venue: "El Born Centre Cultural")
        _ = Concert.from(artist: "Kitsch a la Cova", date: "19-9-2014", venue: "Teatre del Casino")
        _ = Concert.from(artist: "Kitsch a la Cova", date: "21-06-2014", venue: "Auditori de l'Ateneu")
        _ = Concert.from(artist: "Kitsch", date: "14-10-2011", venue: "Teatre del Casino")
        _ = Concert.from(artist: "Kitsch", date: "18-11-2008", venue: "Sala Becool")
        _ = Concert.from(artist: "Kitsch", date: "18-3-2004", venue: "Sala Apolo")
        _ = Concert.from(artist: "Ghost", date: "30-11-2015", venue: "Sala Apolo")
        _ = Concert.from(artist: "Swans", date: "1-10-2014", venue: "Sala Apolo")
        _ = Concert.from(artist: "Nick Cave & The Bad Seeds", date: "21-05-2015", venue: "Auditòri CCIB")
        _ = Concert.from(artist: "Nick Cave & The Bad Seeds", date: "25-04-2008", venue: "Pavelló Olímpic de Badalona")
        _ = Concert.from(artist: "Nick Cave & The Bad Seeds", date: "22-04-2001", venue: "La Riviera")
        _ = Concert.from(artist: "Nick Cave & The Bad Seeds", date: "11-06-1998", venue: "El Pla de Santa Maria")
        _ = Concert.from(artist: "Peter Murphy", date: "21-03-2000", venue: "Irving Plaza")
    }
}
