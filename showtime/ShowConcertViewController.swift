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
    func tweetConcert(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            let tweetVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetVC?.setInitialText("I went to \(concert!) and it was amazing!")
            self.present(tweetVC!, animated: true, completion: nil)
        } else {
            let alert = UIElements.errorAlert(title: "Can't send tweet", message: "Please make sure at least one twitter account is set up in Settings > Twitter")
            present(alert, animated: true, completion: nil)
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

    // dismiss the keyboard when clicking outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func setupSegmentedControlView(segmentedControl: UISegmentedControl) {
        let segment = SegmentedControlSegment(rawValue: segmentedControl.selectedSegmentIndex)!
        updateSegmentedView(for: segment)
    }

    private func updateSegmentedView(for segment: SegmentedControlSegment) {
        switch segment {
        case .notes:
            detailView.subviews.forEach { $0.removeFromSuperview() }
            let notes = ConcertNotesPartial(concert: concert)
            notes.fill(parent: detailView)
        case .setlist:
            detailView.subviews.forEach { $0.removeFromSuperview() }
            let setlist = ConcertSetlistPartial(concert: concert)
            setlist.fill(parent: detailView)
        }
    }
}

extension UIView {
    func fill(parent: UIView) {
        parent.addSubview(self)
        self.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: parent.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: parent.heightAnchor).isActive = true
    }
}
