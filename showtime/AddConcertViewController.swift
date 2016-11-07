//
//  AddConcertViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 05/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

protocol ConcertCreatorDelegate {
    func createdConcert(_ concert: Concert)
}

class AddConcertViewController: UITableViewController {
    // MARK: Outlets
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var venueTextField: UITextField!

    var delegate: ConcertCreatorDelegate?

    private let dateFormatter = DateFormatters.dateParser

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        syncDatePickerWithLabel()
    }

    @IBAction func addConcert(_ sender: UIButton) {
        guard let artist = artistTextField.text, let venue = venueTextField.text else { return }

        let concert = Concert(artist: artist, date: dateTextField.text!, venue: venue)
        delegate?.createdConcert(concert)
        _ = self.navigationController?.popViewController(animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        syncDatePickerWithLabel()
    }

    private func syncDatePickerWithLabel() {
        dateTextField.text = dateFormatter.string(from: datePicker.date)
    }
}
