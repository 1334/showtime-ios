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

    private func setupTabBar() {
        let listNC = UINavigationController(rootViewController: listConcertsVC)
        let addNC = UINavigationController(rootViewController: addConcertVC)

        listNC.tabBarItem = UITabBarItem(title: "Concerts", image: nil, tag: 1)
        addNC.tabBarItem = UITabBarItem(title: "Add Concert", image: nil, tag: 2)

        rootVC.setViewControllers([listNC, addNC], animated: true)
    }

    // MARK: Actions

    func artistSelected(artist: Artist) {
        self.addConcertVC.artistLabel.text = artist.name
        _ = addConcertVC.navigationController?.popViewController(animated: true)
    }

    func concertCreated() {
        rootVC.selectedIndex = 0
    }

    func pickArtist() {
        selectArtistVC.didSelectArtist = artistSelected

        addConcertVC.navigationController?.pushViewController(selectArtistVC, animated: true)
    }

    func pickVenue() {
        selectVenueVC.didSelectVenue = venueSelected

        addConcertVC.navigationController?.pushViewController(selectVenueVC, animated: true)
    }

    @objc func pushSearchArtists() {
        selectArtistVC.navigationController?.pushViewController(searchArtistsVC, animated: true)
    }

    func selectSearchedArtist(searchedArtist: SearchedArtist) {
        let artist = Artist(from: searchedArtist)
        try? CoreDataHelpers.viewContext.save()
        artistSelected(artist: artist)
        _ = searchArtistsVC.navigationController?.popToRootViewController(animated: true)
    }

    func showConcert(concert: Concert) {
        let concertVC = storyboard.instantiateViewController(withIdentifier: "ConcertDetail") as! ShowConcertViewController
        concertVC.concert = concert

        listConcertsVC.navigationController?.pushViewController(concertVC, animated: true)
    }

    func venueSelected(venue: Venue) {
        self.addConcertVC.venueLabel.text = venue.name
        _ = addConcertVC.navigationController?.popViewController(animated: true)
    }

    // MARK: ViewControllers

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
        vc.didSelectArtist = self.selectSearchedArtist
        return vc
    }()

    lazy var selectArtistVC: SelectArtistViewController = {
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectArtist") as! SelectArtistViewController
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushSearchArtists))
        return vc
    }()

    lazy var selectVenueVC: SelectVenueViewController = {
        return storyboard.instantiateViewController(withIdentifier: "SelectVenue") as! SelectVenueViewController
    }()
}
