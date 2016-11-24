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
    let concertsNC: UINavigationController
    let addConcertVC: AddConcertViewController
    let listConcertsVC: ListConcertsViewController
    let searchArtistsVC: SearchArtistsViewController

    init(window: UIWindow) {
        rootVC = window.rootViewController as! UITabBarController
        concertsNC = storyboard.instantiateViewController(withIdentifier: "ConcertsNC") as! UINavigationController
        addConcertVC = storyboard.instantiateViewController(withIdentifier: "AddConcert") as! AddConcertViewController
        listConcertsVC = concertsNC.viewControllers.first as! ListConcertsViewController
        searchArtistsVC = storyboard.instantiateViewController(withIdentifier: "SearchArtists") as! SearchArtistsViewController

        listConcertsVC.didSelect = showConcert
        addConcertVC.didCreateConcert = concertCreated

        setupTabBar()
    }

    func showConcert(concert: Concert) {
        let concertVC = storyboard.instantiateViewController(withIdentifier: "ConcertDetail") as! ShowConcertViewController
        concertVC.concert = concert
        concertsNC.pushViewController(concertVC, animated: true)
    }

    func concertCreated() {
        rootVC.selectedIndex = 0
    }

    private func setupTabBar() {
        concertsNC.tabBarItem = UITabBarItem(title: "Concerts", image: nil, tag: 1)
        addConcertVC.tabBarItem = UITabBarItem(title: "Add Concert", image: nil, tag: 2)
        searchArtistsVC.tabBarItem = UITabBarItem(title: "Search Artists", image: nil, tag: 3)
        rootVC.setViewControllers([concertsNC, addConcertVC, searchArtistsVC], animated: true)
    }
}
