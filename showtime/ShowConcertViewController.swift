//
//  ShowConcertViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 05/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class ShowConcertViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    // MARK: Model
    var concert: Concert!

    override func viewDidLoad() {
        super.viewDidLoad()

        artistLabel.text = "\(concert.artist)"
        venueLabel.text = "\(concert.venue)"
        dateLabel.text = concert.formattedDate
    }

}
