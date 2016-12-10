//
//  SearchArtistsViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 22/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class SearchArtistsViewController: UITableViewController, UISearchBarDelegate {
    enum Sections: Int {
        case searchedArtist = 0
        case newArtist

        static var count: Int { return 2 }
    }

    @IBOutlet weak var searchBar: UISearchBar!
    var artists = [SearchedArtist]()
    var newArtistCell: CustomArtistCell!
    var didSelectArtist: (SearchedArtist) -> () = { _ in }
    var didCreateArtist: (String) -> () = { _ in }

    override func viewDidLoad() {
        setupSearchBar()
        setupTableView()

        if !Utils.isInternetAvailable() {
            UIElements.errorAlert(title: "No internet connection", message: "There is no internet connection available at this time, please try again later", presenter: self, callback: { _ in
                _ = self.navigationController?.popViewController(animated: true)
            })
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            newArtistCell.artistName.text = ""
        } else {
            if searchText.characters.count >= 2 {
                SetlistFmStore().searchArtists(keyword: searchText) { result in
                    switch result {
                    case let .success(foundArtists):
                        self.artists = foundArtists
                    case .failure:
                        self.artists = []
                    }
                    DispatchQueue.main.sync {
                        self.tableView.reloadData()
                    }
                }
            } else {
                artists = []
                tableView.reloadData()
            }
            newArtistCell.artistName.text = searchText
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == Sections.newArtist.rawValue ? 1 : artists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Sections(rawValue: indexPath.section)! {
        case .newArtist:
            let cell = tableView.dequeueReusableCell(withIdentifier: "customArtistCell") as! CustomArtistCell
            newArtistCell = cell
            return cell
        case .searchedArtist:
            let cell = tableView.dequeueReusableCell(withIdentifier: "foundArtist")!
            let artist = artists[indexPath.row]
            cell.textLabel?.text = artist.name
            cell.detailTextLabel?.text = artist.disambiguation

            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Sections(rawValue: indexPath.section)! {
        case .newArtist:
            guard let artistName = newArtistCell.artistName.text else { break }
            if artistName.isEmpty { tableView.deselectRow(at: indexPath, animated: true); break }
            didCreateArtist(artistName)
        case .searchedArtist:
            let searchedArtist = artists[indexPath.row]
            didSelectArtist(searchedArtist)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let searchText = searchBar.text {
            if searchText.isEmpty && indexPath == IndexPath(row: 0, section: 1) {
                return 0
            }
        }
        return UITableViewAutomaticDimension
    }

    // MARK: Private section

    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "enter the artist name"
    }

    private func setupTableView() {
        let nib = UINib(nibName: "CustomArtistCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "customArtistCell")
        tableView.estimatedRowHeight = 65
        tableView.tableFooterView = UIView()
    }
}
