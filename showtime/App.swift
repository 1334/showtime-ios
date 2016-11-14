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
    let navigationController: UINavigationController

    init(window: UIWindow) {
        navigationController = window.rootViewController as! UINavigationController
        let concertsVC = navigationController.viewControllers.first as! ListConcertsViewController
        concertsVC.didSelect = showConcert
    }

    func showConcert(concert: Concert) {
        let concertVC = storyboard.instantiateViewController(withIdentifier: "ConcertDetail") as! ShowConcertViewController
        concertVC.concert = concert
        navigationController.pushViewController(concertVC, animated: true)
    }
}
