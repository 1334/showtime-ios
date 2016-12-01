//
//  SelectVenueViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 13/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

//
//  SelectArtistViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 10/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class SelectVenueViewController : UITableViewController {

    var venues: [Venue]!
    var didSelectVenue: (Venue) -> () = { _ in }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        venues = Venue.all()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "knownVenue", for: indexPath)
        let venue = venues[indexPath.row]
        cell.textLabel?.text = venue.name

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select a venue"
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let venue = venues[indexPath.row]
        didSelectVenue(venue)
    }
    
}

