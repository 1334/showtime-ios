//
//  AddConcertViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 05/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class AddConcertViewController: UITableViewController {

    var didCreateConcert: () -> () = { }
    
    // MARK: Outlets
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    private let dateFormatter = DateFormatters.dateParser

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        syncDatePickerWithLabel()
    }

    @IBAction func addConcert(_ sender: UIButton) {
        guard let artist = artistLabel.text, let venue = venueLabel.text, let date = dateTextField.text else { return }

        if !(artist.isEmpty || venue.isEmpty) {
            _ = Concert(artist: artist, date: date, venue: venue)
            try? CoreDataHelpers.viewContext.save()
            didCreateConcert()
        } else {
            alertFieldsEmpty()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        syncDatePickerWithLabel()
        self.title = "Add New Concert"
    }

    private func syncDatePickerWithLabel() {
        dateTextField.text = dateFormatter.string(from: datePicker.date)
    }

    private func alertFieldsEmpty() {
        let alert = UIAlertController(title: "Empty fields not valid", message: "Please ensure that neither the artist nor the venue are empty", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
