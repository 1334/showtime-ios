//
//  AddConcertViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 05/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class AddConcertViewController: UITableViewController {
    // MARK: Outlets
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var venueTextField: UITextField!

    private let df = DateFormatter()

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        dateTextField.text = df.string(from: datePicker.date)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        df.dateStyle = .long

        dateTextField.text = df.string(from: datePicker.date)
    }
}
