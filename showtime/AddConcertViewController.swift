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

    var didCreateConcert: () -> () = { }
    var pickArtist: () -> () = { }
    var pickVenue: () -> () = { }
    var context = CoreDataHelpers.viewContext
    
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch FormCell(rawValue: indexPath.row)! {
        case .artist:
            pickArtist()
        case .venue:
            pickVenue()
        default:
            break
        }
    }

    @IBAction func addConcert(_ sender: UIButton) {
        guard let artist = artistLabel.text, let venue = venueLabel.text, let date = dateLabel.text else { return }

        if !(artist.isEmpty || venue.isEmpty) {
            _ = Concert(artist: artist, date: date, venue: venue)
            context.saveIt()
            resetForm()
            didCreateConcert()
        } else {
            alertFieldsEmpty()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncDatePickerWithLabel()
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

}
