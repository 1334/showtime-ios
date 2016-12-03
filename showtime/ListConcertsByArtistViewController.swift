//
//  ListConcertsByArtistViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 03/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit
import CoreData

class ListConcertsByArtistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var tableView: UITableView!

    let context = CoreDataHelpers.viewContext
    var fetchedResultController: NSFetchedResultsController<Concert>!
    var didSelect: (Concert) -> () = { _ in }
    var artist: Artist!
    var scope: ConcertScope = .all

    override func viewDidLoad() {
        super.viewDidLoad()
        scope = .artist(artist)
        artistName.text = artist.name
        fetchedResultController = NSFetchedResultsController(fetchRequest: Concert.sortedFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "concertByArtistCell", for: indexPath)
        let concert = fetchedResultController.object(at: indexPath)

        cell.textLabel?.text = "\(concert.venue)"
        cell.detailTextLabel?.text = "\(concert.formattedDate)"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let concert = fetchedResultController.object(at: indexPath)
        didSelect(concert)
    }

}
