//
//  ShowConcertViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 05/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit
import Social

enum SegmentedControlSegment: Int {
    case notes
    case setlist
}

class ShowConcertViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var detailView: UIView!

    // MARK: Actions
    @IBAction func tweetConcert(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            let tweetVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetVC?.setInitialText("I went to \(concert!) and it was amazing!")
            self.present(tweetVC!, animated: true, completion: nil)
        } else {
            print("Can't send tweet")
        }
    }
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        setupSegmentedControlView(segmentedControl: sender)
    }

    // MARK: Model
    var concert: Concert!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Concert details"

        artistLabel.text = "\(concert.artist)"
        venueLabel.text = "\(concert.venue)"
        dateLabel.text = concert.formattedDate

        setupSegmentedControlView(segmentedControl: segmentedControl)
    }

    private func setupSegmentedControlView(segmentedControl: UISegmentedControl) {
        let segment = SegmentedControlSegment(rawValue: segmentedControl.selectedSegmentIndex)!
        updateSegmentedView(for: segment)
    }

    private func updateSegmentedView(for segment: SegmentedControlSegment) {
        switch segment {
        case .notes:
            detailView.subviews.forEach { $0.removeFromSuperview() }
            let subview = ConcertNotesView(concert: concert)
            subview.translatesAutoresizingMaskIntoConstraints = false
            detailView.addSubview(subview)
            subview.centerYAnchor.constraint(equalTo: detailView.centerYAnchor).isActive = true
            subview.centerXAnchor.constraint(equalTo: detailView.centerXAnchor).isActive = true
            subview.widthAnchor.constraint(equalTo: detailView.widthAnchor).isActive = true
            subview.heightAnchor.constraint(equalTo: detailView.heightAnchor).isActive = true
        case .setlist:
            detailView.subviews.forEach { $0.removeFromSuperview() }
            let label = UILabel()
            label.text = "SETLIST"
            label.translatesAutoresizingMaskIntoConstraints = false
            detailView.addSubview(label)
            label.centerYAnchor.constraint(equalTo: detailView.centerYAnchor).isActive = true
            label.centerXAnchor.constraint(equalTo: detailView.centerXAnchor).isActive = true
        }
    }

}
