//
//  ListConcertsViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 02/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit
import CoreData

class ListConcertsViewController: UITableViewController {

    let context = CoreDataHelpers.viewContext
    var fetchedResultController: NSFetchedResultsController<Concert>!
    let searchController = UISearchController(searchResultsController: nil)
    var didSelect: (Concert) -> () = { _ in }
    var scope: ConcertScope = .all

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchedResultController = NSFetchedResultsController(fetchRequest: Concert.sortedFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)

        setupSearchController()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "concertCell", for: indexPath)
        let concert = fetchedResultController.object(at: indexPath)

        cell.textLabel?.text = "\(concert.artist)"
        cell.detailTextLabel?.text = "\(concert.venue) - \(concert.formattedDate)"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let concert = fetchedResultController.object(at: indexPath)
        didSelect(concert)
    }

}

extension ListConcertsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        reloadData(keyword: searchController.searchBar.text!)
    }
}
