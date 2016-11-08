//
//  ShowConcertViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 05/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit
import Social

class ShowConcertViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    // MARK: Actions
    @IBAction func tweetConcert(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            let tweetVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetVC?.setInitialText("I went to \(concert!) and it was amazing!")
            self.present(tweetVC!, animated: true, completion: nil)
        } else {
            NSLog("Can't send tweet")
        }
    }

    // MARK: Model
    var concert: Concert!

    override func viewDidLoad() {
        super.viewDidLoad()

        artistLabel.text = "\(concert.artist)"
        venueLabel.text = "\(concert.venue)"
        dateLabel.text = concert.formattedDate
    }

}
