//
//  App.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 14/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class AppNavigation {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let rootVC: UITabBarController
    var dashboardNC = UINavigationController()
    var concertsNC = UINavigationController()
    var artistsNC = UINavigationController()
    var venuesNC = UINavigationController()
    var addNC = UINavigationController()
    let context = CoreDataHelpers.viewContext

    init(window: UIWindow) {
        window.tintColor = Theme.Colors.tint.color
        Theme.apply()

        rootVC = window.rootViewController as! UITabBarController
        setupTabBar()
    }

    private func setupTabBar() {
        dashboardNC = UINavigationController(rootViewController: dashboardVC)
        concertsNC = UINavigationController(rootViewController: listConcertsVC)
        artistsNC = UINavigationController(rootViewController: listArtistsVC)
        venuesNC = UINavigationController(rootViewController: listVenuesVC)
        addNC = UINavigationController(rootViewController: addConcertVC)

        dashboardNC.tabBarItem = UITabBarItem(title: "Dashboard", image: #imageLiteral(resourceName: "dashboard"), tag: 1)
        concertsNC.tabBarItem = UITabBarItem(title: "Concerts", image: #imageLiteral(resourceName: "concert"), tag: 2)
        artistsNC.tabBarItem = UITabBarItem(title: "Artists", image: #imageLiteral(resourceName: "artist"), tag: 3)
        venuesNC.tabBarItem = UITabBarItem(title: "Venues", image: #imageLiteral(resourceName: "venue"), tag: 4)
        addNC.tabBarItem = UITabBarItem(title: "Add Concert", image: #imageLiteral(resourceName: "addConcert"), tag: 5)

        rootVC.setViewControllers([dashboardNC, concertsNC, artistsNC, venuesNC, addNC], animated: true)
    }

    // MARK: Actions

    func artistSelected(artist: Artist) {
        let targetVC = currentAddConcertViewController
        targetVC.artistLabel.text = artist.name
        _ = rootVC.currentNavigationController?.popViewController(animated: true)
    }

    func concertCreated(concert: Concert) {
        rootVC.selectedIndex = 1
        _ = rootVC.currentNavigationController?.popToRootViewController(animated: true)
        showConcert(concert: concert)
    }

    func createCustomArtist(name: String) {
        let artist = Artist.named(name)
        context.saveIt()
        artistSelected(artist: artist)
        _ = rootVC.currentNavigationController?.popToRootViewController(animated: true)
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
        let artist = Artist.named(searchedArtist.name)
        artist.update(from: searchedArtist)
        context.saveIt()
        artistSelected(artist: artist)
        _ = rootVC.currentNavigationController?.popToRootViewController(animated: true)
    }

    func selectSearchedVenue(searchedVenue: SearchedVenue) {
        let venue = Venue.named(searchedVenue.name)
        venue.update(from: searchedVenue)
        venue.updateCoords()
        context.saveIt()
        venueSelected(venue: venue)
        _ = rootVC.currentNavigationController?.popToRootViewController(animated: true)
    }

    func showConcert(concert: Concert) {
        let concertVC = self.concertVC
        concertVC.concert = concert

        rootVC.currentNavigationController?.pushViewController(concertVC, animated: true)
    }

    func showConcertsForArtist(artist: Artist) {
        let concertsVC = listConcertsByArtistVC
        concertsVC.artist = artist
        rootVC.currentNavigationController?.pushViewController(concertsVC, animated: true)
    }

    func showConcertsForVenue(venue: Venue) {
        let concertsVC = listConcertsByVenueVC
        concertsVC.venue = venue
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
        vc.title = "Add new concert"
        return vc
    }

    var concertVC: ShowConcertViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "ConcertDetail") as! ShowConcertViewController
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: vc.self, action: #selector(vc.self.tweetConcert))
        return vc
    }

    var dashboardVC: DashboardViewContrller {
        let vc = storyboard.instantiateViewController(withIdentifier: "Dashboard") as! DashboardViewContrller
        vc.didSelect = showConcert
        return vc
    }

    var listArtistsVC: ListArtistsViewController {
        let vc = ListArtistsViewController(style: .plain)
        vc.didSelect = showConcertsForArtist
        vc.title = "List Artists"
        return vc
    }

    var listConcertsVC: ListConcertsViewController {
        let vc = ListConcertsViewController(style: .plain)
        vc.didSelect = showConcert
        vc.title = "List Concerts"
        return vc
    }

    var listConcertsByArtistVC: ListConcertsByArtistViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "ListConcertsByArtist") as! ListConcertsByArtistViewController
        vc.didSelect = showConcert
        return vc
    }

    var listConcertsByVenueVC: ListConcertsByVenueViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "ListConcertsByVenue") as! ListConcertsByVenueViewController
        vc.didSelect = showConcert
        return vc
    }

    var listVenuesVC: ListVenuesViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "ListVenues") as! ListVenuesViewController
        vc.title = "Display Venues"
        vc.didSelect = showConcertsForVenue
        return vc
    }

    var searchArtistsVC: SearchArtistsViewController {
        let vc = SearchArtistsViewController(style: .plain)
        vc.didSelectArtist = selectSearchedArtist
        vc.didCreateArtist = createCustomArtist
        vc.title = "Import new artist"
        return vc
    }

    var searchVenuesVC: SearchVenuesViewController {
        let vc = SearchVenuesViewController(style: .plain)
        vc.didSelectVenue = selectSearchedVenue
        vc.title = "Import new venue"
        return vc
    }

    var selectArtistVC: SelectArtistViewController {
        let vc = SelectArtistViewController(style: .plain)
        vc.didSelectArtist = artistSelected
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushSearchArtists))
        vc.title = "Select existing artist"
        vc.navigationItem.backBarButtonItem = UIElements.backButtonItem()
        return vc
    }

    var selectVenueVC: SelectVenueViewController {
        let vc =  SelectVenueViewController(style: .plain)
        vc.didSelectVenue = venueSelected
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushSearchVenues))
        vc.title = "Select existing venue"
        vc.navigationItem.backBarButtonItem = UIElements.backButtonItem()
        return vc
    }
}

extension UITabBarController {
    var currentNavigationController: UINavigationController? {
        return self.selectedViewController as? UINavigationController
    }
}
