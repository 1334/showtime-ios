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

class ShowConcertViewController: ShowtimeBaseViewController {

    // MARK: Outlets
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var detailView: UIView!
    var notesView = UITextView()
    var setlistView: SetlistView?
    var context = CoreDataHelpers.viewContext
    let dateFormatter = DateFormatters.mediumFormatDate

    // MARK: Actions
    func tweetConcert(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            let tweetVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetVC?.setInitialText("I went to \(concert!) and it was amazing!")
            self.present(tweetVC!, animated: true, completion: nil)
        } else {
            UIElements.errorAlert(title: "Can't send tweet", message: "Please make sure at least one twitter account is set up in Settings > Twitter", presenter: self)
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
        view.endEditing(false)
    }

    private func setupSegmentedControlView(segmentedControl: UISegmentedControl) {
        let segment = SegmentedControlSegment(rawValue: segmentedControl.selectedSegmentIndex)!
        updateSegmentedView(for: segment)
    }

    private func updateSegmentedView(for segment: SegmentedControlSegment) {
        switch segment {
        case .notes:
            detailView.subviews.forEach { $0.removeFromSuperview() }
            setupNotesView()
            notesView.fill(parent: detailView)
        case .setlist:
            detailView.subviews.forEach { $0.removeFromSuperview() }
            setupSetlistView()
            setlistView?.fill(parent: detailView)
        }
    }

    private func setupNotesView() {
        notesView.text = concert.notes
        notesView.translatesAutoresizingMaskIntoConstraints = false
        notesView.delegate = self
    }

    private func setupSetlistView() {
        if setlistView == nil {
            setlistView = Bundle.main.loadNibNamed("SetlistView", owner: self, options: [:])?.first as? SetlistView
            setlistView?.translatesAutoresizingMaskIntoConstraints = false
            setlistView?.refreshSetlist.addTarget(self, action: #selector(retrieveSetlist), for: .touchUpInside)
        }

        if let updatedAt = concert.setlistUpdatedAt {
            setlistView?.setlistText.text = concert.setlistText
            setlistView?.updatedAtText.text = "last update: \(dateFormatter.string(from: updatedAt))"
            setlistView?.setlistText.scrollRangeToVisible(NSRange(location:0, length:0))
        } else {
            retrieveSetlist()
        }
    }

    @objc private func retrieveSetlist() {
        SetlistFmStore().searchSetlist(artist: concert.artist.name, date: concert.date) { result in
            switch result {
            case let .success(setlist):
                self.concert.updateSetlist(setlist)
            default:
                self.concert.setlistUpdatedAt = Date()
            }
            DispatchQueue.main.sync {
                self.context.saveIt()
                self.setupSetlistView()
            }
        }
    }

}

extension ShowConcertViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        saveNotes()
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        animateTextView(textView, up: true)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        animateTextView(textView, up: false)
    }

    func animateTextView(_ textView: UITextView, up: Bool) {
        let distance: CGFloat = 210.0
        let duration = 0.5

        let movement = up ? -distance : distance
        UIView.animate(withDuration: duration) {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        }
    }

    func saveNotes() {
        if notesView.text.isEmpty {
            concert.notes = nil
        } else {
            concert.notes = notesView.text
        }
        context.saveIt()
    }
}
