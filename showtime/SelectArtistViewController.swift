//
//  SelectArtistViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 10/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class SelectArtistViewController : UITableViewController {

    var artists: [Artist]!
    var didSelectArtist: (Artist) -> () = { _ in }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        artists = Artist.all()
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "knownArtist", for: indexPath)
        let artist = artists[indexPath.row]
        cell.textLabel?.text = artist.name

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artist = artists[indexPath.row]
        didSelectArtist(artist)
    }
    
}
