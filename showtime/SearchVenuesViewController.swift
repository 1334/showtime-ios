//
//  SearchVenuesViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 30/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class SearchVenuesViewController: ShowtimeBaseTableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    var venues = [SearchedVenue]()
    var didSelectVenue: (SearchedVenue) -> () = { _ in }

    override func viewDidLoad() {
        searchBar.delegate = self
        searchBar.placeholder = "enter the venue name to search"
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            venues = []
            tableView.reloadData()
        } else {
            SetlistFmStore().searchVenue(name: searchText) { result in
                switch result {
                case let .success(foundVenues):
                    self.venues = foundVenues
                case .failure:
                    self.venues = []
                }
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foundVenue")!
        let venue = venues[indexPath.row]
        cell.textLabel?.text = venue.name
        cell.detailTextLabel?.text = venue.location

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchedVenue = venues[indexPath.row]
        didSelectVenue(searchedVenue)
    }
}

