//
//  App.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 14/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class App {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let rootVC: UITabBarController
    var concertsNC = UINavigationController()
    var artistsNC = UINavigationController()
    var addNC = UINavigationController()

    init(window: UIWindow) {
        rootVC = window.rootViewController as! UITabBarController
        setupTabBar()
    }

    private func setupTabBar() {
        concertsNC = UINavigationController(rootViewController: listConcertsVC)
        artistsNC = UINavigationController(rootViewController: listArtistsVC)
        addNC = UINavigationController(rootViewController: addConcertVC)

        concertsNC.tabBarItem = UITabBarItem(title: "Concerts", image: UIImage(named: "concert"), tag: 1)
        artistsNC.tabBarItem = UITabBarItem(title: "Artists", image: UIImage(named: "artist"), tag: 2)
        addNC.tabBarItem = UITabBarItem(title: "Add Concert", image: UIImage(named: "addConcert"), tag: 3)

        rootVC.setViewControllers([concertsNC, artistsNC, addNC], animated: true)
    }

    // MARK: Actions

    func artistSelected(artist: Artist) {
        let targetVC = currentAddConcertViewController
        targetVC.artistLabel.text = artist.name
        _ = rootVC.currentNavigationController?.popViewController(animated: true)
    }

    func concertCreated() {
        rootVC.selectedIndex = 0
    }

    func pickArtist() {
        rootVC.currentNavigationController?.pushViewController(selectArtistVC, animated: true)
    }

    func pickVenue() {
        rootVC.currentNavigationController?.pushViewController(selectVenueVC, animated: true)
    }

    @objc func pushSearchArtists() {
        rootVC.currentNavigationController?.pushViewController(searchArtistsVC, animated: true)
    }

    @objc func pushSearchVenues() {
        rootVC.currentNavigationController?.pushViewController(searchVenuesVC, animated: true)
    }

    func selectSearchedArtist(searchedArtist: SearchedArtist) {
        let artist = Artist(from: searchedArtist)
        try? CoreDataHelpers.viewContext.save()
        artistSelected(artist: artist)
        _ = rootVC.currentNavigationController?.popToRootViewController(animated: true)
    }

    func selectSearchedVenue(searchedVenue: SearchedVenue) {
        let venue = Venue(from: searchedVenue)
        try? CoreDataHelpers.viewContext.save()
        venueSelected(venue: venue)
        _ = rootVC.currentNavigationController?.popToRootViewController(animated: true)
    }

    func showConcert(concert: Concert) {
        let concertVC = self.concertVC
        concertVC.concert = concert

        rootVC.currentNavigationController?.pushViewController(concertVC, animated: true)

    }

    func showConcertsForArtist(artist: Artist) {
        let concertsVC = listConcertsVC
        concertsVC.scope = .artist(artist)
        rootVC.currentNavigationController?.pushViewController(concertsVC, animated: true)
    }

    func venueSelected(venue: Venue) {
        let targetVC = currentAddConcertViewController
        targetVC.venueLabel.text = venue.name
        _ = rootVC.currentNavigationController?.popViewController(animated: true)
    }

    var currentAddConcertViewController: AddConcertViewController {
        return rootVC.currentNavigationController?.viewControllers.filter { $0 as? AddConcertViewController != nil }.first as! AddConcertViewController
    }

    // MARK: ViewControllers

    var addConcertVC: AddConcertViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "AddConcert") as! AddConcertViewController
        vc.didCreateConcert = concertCreated
        vc.pickArtist = pickArtist
        vc.pickVenue = pickVenue
        return vc
    }

    var concertVC: ShowConcertViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "ConcertDetail") as! ShowConcertViewController
        return vc
    }

    var listArtistsVC: ListArtistsViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "ListArtists") as! ListArtistsViewController
        vc.didSelect = showConcertsForArtist
        return vc
    }

    var listConcertsVC: ListConcertsViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "ListConcerts") as! ListConcertsViewController
        vc.didSelect = showConcert
        return vc
    }

    var searchArtistsVC: SearchArtistsViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchArtists") as! SearchArtistsViewController
        vc.didSelectArtist = selectSearchedArtist
        return vc
    }

    var searchVenuesVC: SearchVenuesViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchVenues") as! SearchVenuesViewController
        vc.didSelectVenue = selectSearchedVenue
        return vc
    }

    var selectArtistVC: SelectArtistViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectArtist") as! SelectArtistViewController
        vc.didSelectArtist = artistSelected
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushSearchArtists))
        return vc
    }

    var selectVenueVC: SelectVenueViewController {
        let vc =  storyboard.instantiateViewController(withIdentifier: "SelectVenue") as! SelectVenueViewController
        vc.didSelectVenue = venueSelected
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushSearchVenues))
        return vc
    }
}

extension UITabBarController {
    var currentNavigationController: UINavigationController? {
        return self.selectedViewController as? UINavigationController
    }
}
