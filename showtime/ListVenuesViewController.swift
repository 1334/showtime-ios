//
//  ListVenuesViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 04/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit
import MapKit

class ListVenuesViewController: ShowtimeBaseViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var map: MKMapView!
    var venues = Venue.all()
    var didSelect: (Venue) -> () = { _ in }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        reloadAnnotations()
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

    // MARK: Private section

    func setupMap() {
        map.delegate = self
        map.isPitchEnabled = false
        map.isRotateEnabled = false
        disableDefaultDoubleTap()
        defineCustomDoubleTap()
        zoomExtends()
    }

    func zoomExtends() {
        map.showAnnotations(venues, animated: true)
    }

    func reloadAnnotations() {
        map.removeAnnotations(map.annotations)
        venues = Venue.all()
        map.addAnnotations(venues)
    }

    func disableDefaultDoubleTap() {
        // Apple's default gestures are added to a map subiew, 
        // traverse them to remove the default double tap behaviour.
        for view in map.subviews {
            for gesture in view.gestureRecognizers ?? [] {
                guard let tapGesture = gesture as? UITapGestureRecognizer else { return }

                if tapGesture.numberOfTapsRequired == 2 {
                    map.subviews[0].removeGestureRecognizer(tapGesture)
                }
            }
        }
    }

    func defineCustomDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(mapDoubleTapped))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        map.addGestureRecognizer(doubleTap)
    }

    func mapDoubleTapped() {
        zoomExtends()
    }
}
