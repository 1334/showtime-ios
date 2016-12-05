//
//  ListVenuesViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 04/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit
import MapKit

class ListVenuesViewController: UIViewController {
    @IBOutlet weak var map: MKMapView!
    var venues = Venue.all()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        map.addAnnotations(venues)
        map.showAnnotations(venues, animated: true)
    }

}
