//
//  ListConcertsByVenueViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 07/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class ListConcertsByVenueViewController: ShowtimeBaseViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    @IBOutlet weak var venueName: UILabel!
    @IBOutlet weak var showsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!

    let context = CoreDataHelpers.viewContext
    var fetchedResultController: NSFetchedResultsController<Concert>!
    var didSelect: (Concert) -> () = { _ in }
    var venue: Venue!
    var scope: ConcertScope = .all

    override func viewDidLoad() {
        super.viewDidLoad()
        scope = .venue(venue)
        setupLabels()
        setupMapView()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    func reloadData() {
        fetchedResultController.fetchRequest.predicate = scope.predicate
        try? fetchedResultController.performFetch()

        tableView.reloadData()
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.sections?[section].numberOfObjects ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "concertByVenue", for: indexPath)
        let concert = fetchedResultController.object(at: indexPath)

        cell.textLabel?.text = "\(concert.artist)"
        cell.detailTextLabel?.text = "\(concert.formattedDate)"
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let concert = fetchedResultController.object(at: indexPath)
        didSelect(concert)
    }

    // MARK: - MapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view: MKAnnotationView! = mapView.dequeueReusableAnnotationView(withIdentifier: "venueCell")
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "venueCell")
            view.canShowCallout = false
        } else {
            view.annotation = annotation
        }
        view.isDraggable = true

        return view
    }

    // MARK: Private section

    private func setupLabels() {
        venueName.text = venue.name
        venueName.style(Theme.Styles.contrastTitle.style)
        showsLabel.style(Theme.Styles.subtitle.style)
    }

    private func setupMapView() {
        mapView.delegate = self
        mapView.addAnnotation(venue)
        mapView.showAnnotations([venue], animated: false)
    }

    private func setupTableView() {
        fetchedResultController = NSFetchedResultsController(fetchRequest: Concert.sortedFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        tableView.register(RightDetailCell.self, forCellReuseIdentifier: "concertByVenue")
    }


}
