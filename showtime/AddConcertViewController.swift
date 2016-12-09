//
//  AddConcertViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 05/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

enum FormCell: Int {
    case artist
    case dateLabel
    case datePicker
    case venue
    case add
}

class AddConcertViewController: UITableViewController {

    var didCreateConcert: (Concert) -> () = { _ in }
    var pickArtist: () -> () = { }
    var pickVenue: () -> () = { }
    var context = CoreDataHelpers.viewContext
    private var datePickerVisible = false
    
    // MARK: Outlets
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!

    private let dateFormatter = DateFormatters.dateParser

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        syncDatePickerWithLabel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncDatePickerWithLabel()
        if datePickerVisible {
            toggleDatepicker()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch FormCell(rawValue: indexPath.row)! {
        case .artist:
            pickArtist()
        case .venue:
            pickVenue()
        case .dateLabel:
            toggleDatepicker()
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addConcert(_ sender: UIButton) {
        guard let artist = artistLabel.text, let venue = venueLabel.text, let date = dateLabel.text else { return }

        if !(artist.isEmpty || venue.isEmpty) {
            let concert = Concert(artist: artist, date: date, venue: venue)
            context.saveIt()
            resetForm()
            didCreateConcert(concert)
        } else {
            alertFieldsEmpty()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch FormCell(rawValue: indexPath.row)! {
        case .datePicker:
            return !datePickerVisible ? 0 : 212.0
        default:
            return 44.0
        }
    }

    // MARK: Private section

    private func alertFieldsEmpty() {
        let alert = UIElements.errorAlert(title: "Empty fields not valid", message: "Please ensure that neither the artist nor the venue are empty")
        self.present(alert, animated: true, completion: nil)
    }

    private func resetForm() {
        artistLabel.text = ""
        venueLabel.text = ""
        datePicker.date = Date()
    }

    private func setupTableView() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
    }

    private func syncDatePickerWithLabel() {
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }

    private func toggleDatepicker() {
        datePickerVisible = !datePickerVisible
        datePicker.isHidden = !datePickerVisible

        tableView.beginUpdates()
        tableView.endUpdates()
    }

}
