//
//  App.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 14/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class App {

    static let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let rootVC: UITabBarController

    init(window: UIWindow) {
        rootVC = window.rootViewController as! UITabBarController

        setupTabBar()
    }

    lazy var addConcertVC: AddConcertViewController = {
        let vc = storyboard.instantiateViewController(withIdentifier: "AddConcert") as! AddConcertViewController
        vc.didCreateConcert = self.concertCreated
        vc.pickArtist = self.pickArtist
        vc.pickVenue = self.pickVenue
        return vc
    }()

    lazy var listConcertsVC: ListConcertsViewController = {
        let vc = storyboard.instantiateViewController(withIdentifier: "ListConcerts") as! ListConcertsViewController
        vc.didSelect = self.showConcert
        return vc
    }()

    lazy var searchArtistsVC: SearchArtistsViewController = {
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchArtists") as! SearchArtistsViewController
        return vc
    }()

    func showConcert(concert: Concert) {
        let concertVC = storyboard.instantiateViewController(withIdentifier: "ConcertDetail") as! ShowConcertViewController
        concertVC.concert = concert

        listConcertsVC.navigationController?.pushViewController(concertVC, animated: true)
    }

    func concertCreated() {
        rootVC.selectedIndex = 0
    }

    func pickArtist() {
        let selectArtistVC = storyboard.instantiateViewController(withIdentifier: "SelectArtist") as! SelectArtistViewController
        selectArtistVC.didSelectArtist = artistSelected

        addConcertVC.navigationController?.pushViewController(selectArtistVC, animated: true)
    }

    func artistSelected(artist: Artist) {
        self.addConcertVC.artistLabel.text = artist.name
        _ = addConcertVC.navigationController?.popViewController(animated: true)
    }

    func pickVenue() {
        let selectVenueVC = storyboard.instantiateViewController(withIdentifier: "SelectVenue") as! SelectVenueViewController
        selectVenueVC.didSelectVenue = venueSelected

        addConcertVC.navigationController?.pushViewController(selectVenueVC, animated: true)
    }

    func venueSelected(venue: Venue) {
        self.addConcertVC.venueLabel.text = venue.name
        _ = addConcertVC.navigationController?.popViewController(animated: true)
    }


    private func setupTabBar() {
        let listNC = UINavigationController(rootViewController: listConcertsVC)
        let addNC = UINavigationController(rootViewController: addConcertVC)

        listNC.tabBarItem = UITabBarItem(title: "Concerts", image: nil, tag: 1)
        addNC.tabBarItem = UITabBarItem(title: "Add Concert", image: nil, tag: 2)
        searchArtistsVC.tabBarItem = UITabBarItem(title: "Search Artists", image: nil, tag: 3)

        rootVC.setViewControllers([listNC, addNC, searchArtistsVC], animated: true)
    }
}
