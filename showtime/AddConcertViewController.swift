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

class AddConcertViewController: UITableViewController, SegueHandlerType {
    enum SegueIdentifier: String {
        case selectArtist = "selectArtist"
    }
    
    // MARK: Outlets
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var venueTextField: UITextField!

    var delegate: ConcertCreatorDelegate?

    private let dateFormatter = DateFormatters.dateParser

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        syncDatePickerWithLabel()
    }

    @IBAction func addConcert(_ sender: UIButton) {
        guard let artist = artistLabel.text, let venue = venueTextField.text else { return }

        if !(artist.isEmpty || venue.isEmpty) {
            //let concert = Concert(artist: artist, date: dateTextField.text!, venue: venue)
            //delegate?.createdConcert(concert)
            _ = self.navigationController?.popViewController(animated: true)
        } else {
            alertFieldsEmpty()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        syncDatePickerWithLabel()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .selectArtist:
            break
        }
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
