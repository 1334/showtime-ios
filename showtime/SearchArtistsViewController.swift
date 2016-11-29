//
//  SearchArtistsViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 22/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class SearchArtistsViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    var artists = [SearchedArtist]()
    var didSelectArtist: (SearchedArtist) -> () = { _ in }

    override func viewDidLoad() {
        searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text , !searchText.isEmpty else { return }
        SetlistFmStore().searchArtists(keyword: searchText) { result in
            switch result {
            case let .success(foundArtists):
                print(foundArtists)
                DispatchQueue.main.sync {
                    self.artists = foundArtists
                    self.tableView.reloadData()
                }
            case let .failure(error):
                print(error)
                break
            }

        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foundArtist")!
        let artist = artists[indexPath.row]
        cell.textLabel?.text = artist.name
        cell.detailTextLabel?.text = artist.disambiguation

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchedArtist = artists[indexPath.row]
        didSelectArtist(searchedArtist)
    }
}
