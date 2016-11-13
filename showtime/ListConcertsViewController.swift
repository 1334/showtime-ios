//
//  ListConcertsViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 02/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit
import CoreData

class ListConcertsViewController: UITableViewController, SegueHandlerType {

    enum SegueIdentifier: String {
        case showConcert = "showConcert"
        case addConcert = "addConcert"
    }

    let context = CoreDataHelpers.viewContext
    var concerts = [Concert]()
    var filteredConcerts = [Concert]()
    let searchController  = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // create sample data
//        let concert = Concert(context: context)
//        let artist = Artist(context: context)
//        let venue = Venue(context: context)
//
//        artist.name = "Iggy Pop"
//        venue.name = "Studio 54"
//        concert.date = Date(timeIntervalSinceNow: 0)
//        concert.artist = artist
//        concert.venue = venue
//        try? context.save()

        concerts = Concert.all()

        setupSearchController()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Search Controller

    func filterContent(for searchText: String) {
        filteredConcerts = concerts.filter { concert in
            return concert.artist.name.lowercased().contains(searchText.lowercased()) ||
                concert.venue.name.lowercased().contains(searchText.lowercased())

        }

        tableView.reloadData()
    }

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isInTheMiddleOfASearch() ? filteredConcerts.count : concerts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "concertCell", for: indexPath)
        let concert = isInTheMiddleOfASearch() ? filteredConcerts[indexPath.row] : concerts[indexPath.row]

        cell.textLabel?.text = "\(concert.artist)"
        cell.detailTextLabel?.text = "\(concert.venue) - \(concert.formattedDate)"

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .showConcert:
            guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else { return }
            if let vc = segue.destination as? ShowConcertViewController {
                vc.concert = isInTheMiddleOfASearch() ? filteredConcerts[indexPath.row] : concerts[indexPath.row]
            }
        case .addConcert:
            if let vc = segue.destination as? AddConcertViewController {
                vc.delegate = self
            }
        }
    }

    private func isInTheMiddleOfASearch() -> Bool {
        return searchController.isActive && searchController.searchBar.text != ""
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
        filterContent(for: searchController.searchBar.text!)
    }
}

extension ListConcertsViewController: ConcertCreatorDelegate {
    func createdConcert(_ concert: Concert) {
        concerts.append(concert)

        tableView.reloadData()
    }
}
