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

class AddConcertViewController: ShowtimeBaseStaticTableViewController {

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
    @IBOutlet weak var addConcertButton: UIButton!

    private let dateFormatter = DateFormatters.dateParser

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        syncDatePickerWithLabel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupTableView()
        setupLabels()
        setupDatePicker()
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

    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return FormCell(rawValue: indexPath.row)! == .add ? false : true
    }

    @IBAction func addConcert(_ sender: UIButton) {
        guard let artist = artistLabel.text, let venue = venueLabel.text, let date = dateLabel.text else { return }

        if !(artist.isEmpty || venue.isEmpty) {
            let concert = Concert.from(artist: artist, date: date, venue: venue)
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
        case .add:
            return 90
        default:
            return UITableViewAutomaticDimension
        }
    }

    // MARK: Private section

    private func alertFieldsEmpty() {
        UIElements.errorAlert(title: "Empty fields not valid", message: "Please ensure that neither the artist nor the venue are empty", presenter: self)
    }

    private func resetForm() {
        artistLabel.text = ""
        venueLabel.text = ""
        datePicker.date = Date()
    }

    private func setupButton() {
        addConcertButton.backgroundColor = Theme.Colors.tint.color.withAlphaComponent(0.2)
    }

    private func setupLabels() {
        artistLabel.style(Theme.Styles.bold.style)
        venueLabel.style(Theme.Styles.bold.style)
        dateLabel.style(Theme.Styles.bold.style)
    }

    private func setupDatePicker() {
        datePicker.setValue(Theme.Colors.foreground.color, forKey: "textColor")
    }

    private func setupTableView() {
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
