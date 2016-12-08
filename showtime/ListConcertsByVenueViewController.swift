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

class ListConcertsByVenueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var venueName: UILabel!
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
        venueName.text = venue.name
//        imageView.image = artist.image
        fetchedResultController = NSFetchedResultsController(fetchRequest: Concert.sortedFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    func reloadData() {
        fetchedResultController.fetchRequest.predicate = scope.predicate
        try! fetchedResultController.performFetch()

        tableView.reloadData()
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.sections?[section].numberOfObjects ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "concertByVenueCell", for: indexPath)
        let concert = fetchedResultController.object(at: indexPath)

        cell.textLabel?.text = "\(concert.artist)"
        cell.detailTextLabel?.text = "\(concert.formattedDate)"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let concert = fetchedResultController.object(at: indexPath)
        didSelect(concert)
    }
}
