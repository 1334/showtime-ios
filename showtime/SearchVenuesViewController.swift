//
//  SearchVenuesViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 30/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class SearchVenuesViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    var venues = [SearchedVenue]()
    var didSelectVenue: (SearchedVenue) -> () = { _ in }

    override func viewDidLoad() {
        searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text , !searchText.isEmpty else { return }
        SetlistFmStore().searchVenue(name: searchText) { result in
            switch result {
            case let .success(foundVenues):
                print(foundVenues)
                DispatchQueue.main.sync {
                    self.venues = foundVenues
                    self.tableView.reloadData()
                }
            case .failure:
                DispatchQueue.main.sync {
                    let alert = UIElements.errorAlert(title: "No results", message: "Your search didn't find any results")
                    self.present(alert, animated: true, completion: nil)
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
        cell.detailTextLabel?.text = venue.cityName

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchedVenue = venues[indexPath.row]
        didSelectVenue(searchedVenue)
    }
}

