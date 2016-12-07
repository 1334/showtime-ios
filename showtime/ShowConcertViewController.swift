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
    var notesView = UITextView()
    var setlistView = UITextView()
    var context = CoreDataHelpers.viewContext

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
        print(touches)
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
            setlistView.fill(parent: detailView)
        }
    }

    private func setupNotesView() {
        notesView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        notesView.text = concert.notes
        notesView.translatesAutoresizingMaskIntoConstraints = false
        notesView.delegate = self
    }

    private func setupSetlistView() {
        setlistView.backgroundColor = UIColor(red: 0.95, green: 0.8, blue: 1, alpha: 1)
        setlistView.isEditable = false
        if concert.setlistUpdatedAt == nil {
            retrieveSetlist()
        } else {
            setlistView.text = concert.setlistText
        }
        setlistView.textAlignment = .center
        setlistView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func retrieveSetlist() {
        SetlistFmStore().searchSetlist(artist: concert.artist.name, date: concert.date) { result in
            switch result {
            case let .success(setlist):
                DispatchQueue.main.sync {
                    self.concert.setlist = setlist.setlist.map { $0.joined(separator: "\n") }.joined(separator: "\n\n")
                    self.concert.setlistUpdatedAt = setlist.updatedAt
                    self.context.saveIt()
                    self.setlistView.text = self.concert.setlistText
                }
            default:
                DispatchQueue.main.sync {
                    self.setlistView.text = "setlist not found"
                }
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
