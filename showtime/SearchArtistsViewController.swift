//
//  SearchArtistsViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 22/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class SearchArtistsViewController: ShowtimeBaseTableViewController, UISearchBarDelegate {
    enum Sections: Int {
        case searchedArtist = 0
        case newArtist

        static var count: Int { return 2 }
    }

    var searchBar: UISearchBar!
    var artists = [SearchedArtist]()
    var newArtistCell: CustomArtistCell!
    var didSelectArtist: (SearchedArtist) -> () = { _ in }
    var didCreateArtist: (String) -> () = { _ in }
    private var timer = Timer()

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
        if timer.isValid {
            timer.invalidate()
            timer = startTimer()
        } else {
            timer = startTimer()
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "customArtist") as! CustomArtistCell
            newArtistCell = cell
            return cell
        case .searchedArtist:
            let cell = tableView.dequeueReusableCell(withIdentifier: "foundArtist") as! SubtitleCell
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
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "enter the artist name"
        searchBar.sizeToFit()
    }

    private func setupTableView() {
        let nib = UINib(nibName: "CustomArtistCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "customArtist")
        tableView.register(SubtitleCell.self, forCellReuseIdentifier: "foundArtist")
        tableView.estimatedRowHeight = CGFloat(Theme.Constants.estimatedRowHeight.rawValue)
        tableView.tableHeaderView = searchBar
    }

    private func startTimer() -> Timer {
        return Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(searchArtists), userInfo: nil, repeats: false)
    }

    @objc private func searchArtists() {
        guard let searchText = searchBar.text else { return }

        if searchText.characters.count >= 2 {
            SetlistFmStore().searchArtists(keyword: searchText) { result in
                DispatchQueue.main.async {
                    switch result {
                    case let .success(foundArtists):
                        self.artists = foundArtists
                    case .failure:
                        self.artists = []
                    }
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
