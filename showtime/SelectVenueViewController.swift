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

    override func viewDidLoad() {
        super.viewDidLoad()
        venues = Venue.all()
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
        for pvc in presentingViewController!.childViewControllers {
            if let vc = pvc as? AddConcertViewController {
                vc.venueLabel.text = venues[indexPath.row].name
                vc.presentedViewController?.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
}

