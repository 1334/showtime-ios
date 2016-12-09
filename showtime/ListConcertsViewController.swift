//
//  ListConcertsViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 02/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit
import CoreData

class ListConcertsViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    let context = CoreDataHelpers.viewContext
    var fetchedResultController: NSFetchedResultsController<Concert>!
    let searchController = UISearchController(searchResultsController: nil)
    var didSelect: (Concert) -> () = { _ in }
    var scope: ConcertScope = .all

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchedResultController = NSFetchedResultsController(fetchRequest: Concert.sortedFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self

        setupSearchController()
        let nib = UINib(nibName: "ConcertCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "concertCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    func reloadData(keyword: String = "") {
        if !keyword.isEmpty {
            let predicate = Concert.predicateMatching(keyword: keyword)
            fetchedResultController.fetchRequest.predicate = predicate
        } else {
            fetchedResultController.fetchRequest.predicate = scope.predicate
        }
        try? fetchedResultController.performFetch()

        tableView.reloadData()
    }

    // MARK: - Search Controller

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "concertCell", for: indexPath) as! ConcertCell

        let concert = fetchedResultController.object(at: indexPath)

        cell.artistLabel.text = "\(concert.artist)"
        cell.venueLabel.text = "\(concert.venue)"
        cell.dateLabel.text = "\(concert.formattedDate)"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let concert = fetchedResultController.object(at: indexPath)
        didSelect(concert)
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let concert = fetchedResultController.object(at: indexPath)
        context.delete(concert)
        context.saveIt()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .delete {
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        }
    }

}

extension ListConcertsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        reloadData(keyword: searchController.searchBar.text!)
    }
}
