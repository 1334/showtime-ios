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
            let predicate = NSPredicate(format: "artist.name CONTAINS[c] %@ OR venue.name CONTAINS[c] %@", keyword, keyword)
            fetchedResultController.fetchRequest.predicate = predicate
        } else {
            fetchedResultController.fetchRequest.predicate = Concert.defaultPredicate
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListConcertsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        reloadData(keyword: searchController.searchBar.text!)
    }
}

extension ListConcertsViewController: ConcertCreatorDelegate {
    func createdConcert(_ concert: Concert) {
        context.insert(concert)
        try! context.save()

        reloadData()
    }
}
