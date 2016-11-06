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

    private let dateFormatter = DateFormatters.longFormatDate

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        syncDatePickerWithLabel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        syncDatePickerWithLabel()
    }

    private func syncDatePickerWithLabel() {
        dateTextField.text = dateFormatter.string(from: datePicker.date)
    }
}
