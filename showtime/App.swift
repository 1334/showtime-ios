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
    var venuesNC = UINavigationController()
    var addNC = UINavigationController()

    init(window: UIWindow) {
        window.tintColor = Theme.Colors.tint.color
//        let tabBarAppearance = UITabBar.appearance()
//        tabBarAppearance.barStyle = .black
//        let navBarAppearance = UINavigationBar.appearance()
//        navBarAppearance.barStyle = .black
//        let tvAppearance = UITableView.appearance()
//        tvAppearance.backgroundColor = .black
//        tvAppearance.tintColor = .purple
//        let tvcAppearance = UITableViewCell.appearance()
//        tvcAppearance.tintColor = .purple
//        tvcAppearance.backgroundColor = .black
//        let labelAppearance = UILabel.appearance()
//        labelAppearance.textColor = .purple
//        let searchAppearance = UISearchBar.appearance()
//        searchAppearance.barStyle = .black

        rootVC = window.rootViewController as! UITabBarController
        setupTabBar()
    }

    private func setupTabBar() {
        concertsNC = UINavigationController(rootViewController: listConcertsVC)
        artistsNC = UINavigationController(rootViewController: listArtistsVC)
        venuesNC = UINavigationController(rootViewController: listVenuesVC)
        addNC = UINavigationController(rootViewController: addConcertVC)

        concertsNC.tabBarItem = UITabBarItem(title: "Concerts", image: #imageLiteral(resourceName: "concert"), tag: 2)
        artistsNC.tabBarItem = UITabBarItem(title: "Artists", image: #imageLiteral(resourceName: "artist"), tag: 3)
        venuesNC.tabBarItem = UITabBarItem(title: "Venues", image: #imageLiteral(resourceName: "venue"), tag: 4)
        addNC.tabBarItem = UITabBarItem(title: "Add Concert", image: #imageLiteral(resourceName: "addConcert"), tag: 5)

        rootVC.setViewControllers([concertsNC, artistsNC, venuesNC, addNC], animated: true)
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
        let concertsVC = listConcertsByArtistVC
        concertsVC.artist = artist
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
        return vc
    }

    var listArtistsVC: ListArtistsViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "ListArtists") as! ListArtistsViewController
        vc.didSelect = showConcertsForArtist
        vc.title = "List Artists"
        return vc
    }

    var listConcertsVC: ListConcertsViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "ListConcerts") as! ListConcertsViewController
        vc.didSelect = showConcert
        vc.title = "List Concerts"
        return vc
    }

    var listConcertsByArtistVC: ListConcertsByArtistViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "ListConcertsByArtist") as! ListConcertsByArtistViewController
        vc.didSelect = showConcert
        return vc
    }

    var listVenuesVC: ListVenuesViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "ListVenues") as! ListVenuesViewController
        vc.title = "Display Venues"
        return vc
    }

    var searchArtistsVC: SearchArtistsViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchArtists") as! SearchArtistsViewController
        vc.didSelectArtist = selectSearchedArtist
        vc.title = "Import new artist"
        return vc
    }

    var searchVenuesVC: SearchVenuesViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchVenues") as! SearchVenuesViewController
        vc.didSelectVenue = selectSearchedVenue
        vc.title = "Import new venue"
        return vc
    }

    var selectArtistVC: SelectArtistViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectArtist") as! SelectArtistViewController
        vc.didSelectArtist = artistSelected
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushSearchArtists))
        vc.title = "Select existing artist"
        return vc
    }

    var selectVenueVC: SelectVenueViewController {
        let vc =  storyboard.instantiateViewController(withIdentifier: "SelectVenue") as! SelectVenueViewController
        vc.didSelectVenue = venueSelected
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushSearchVenues))
        vc.title = "Select existing venue"
        return vc
    }
}

extension UITabBarController {
    var currentNavigationController: UINavigationController? {
        return self.selectedViewController as? UINavigationController
    }
}
