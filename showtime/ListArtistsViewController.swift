//
//  ListArtistsViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 02/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//


import UIKit
import CoreData

class ListArtistsViewController: UITableViewController {

    let context = CoreDataHelpers.viewContext
    var fetchedResultController: NSFetchedResultsController<Artist>!
    let searchController = UISearchController(searchResultsController: nil)
    var didSelect: (Artist) -> () = { _ in }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchedResultController = NSFetchedResultsController(fetchRequest: Artist.sortedFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)

        setupSearchController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    func reloadData(keyword: String = "") {
        if !keyword.isEmpty {
            let predicate = Artist.predicateMatching(keyword: keyword)
            fetchedResultController.fetchRequest.predicate = predicate
        } else {
            fetchedResultController.fetchRequest.predicate = Artist.defaultPredicate
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath)
        let artist = fetchedResultController.object(at: indexPath)

        cell.textLabel?.text = "\(artist)"
        cell.detailTextLabel?.text = "\(artist.concerts.count) concerts"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artist = fetchedResultController.object(at: indexPath)
        didSelect(artist)
    }

}

extension ListArtistsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        reloadData(keyword: searchController.searchBar.text!)
    }
}
