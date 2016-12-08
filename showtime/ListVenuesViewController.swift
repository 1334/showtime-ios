//
//  ListVenuesViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 04/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit
import MapKit

class ListVenuesViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var map: MKMapView!
    var venues: [Venue]!
    var didSelect: (Venue) -> () = { _ in }

    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        map.isPitchEnabled = false
        map.isRotateEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        venues = Venue.all()
        map.addAnnotations(venues)
        map.showAnnotations(venues, animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view: MKAnnotationView! = mapView.dequeueReusableAnnotationView(withIdentifier: "venueCell")
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "venueCell")
            view.canShowCallout = true
        } else {
            view.annotation = annotation
        }
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

        return view
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let venue = view.annotation as? Venue else { return }
        didSelect(venue)
    }
}
