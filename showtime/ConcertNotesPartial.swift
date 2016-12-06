//
//  ConcertNotesView.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 26/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class ConcertNotesPartial: UIView {
    var concert: Concert!
    private var textView: UITextView!
    var context = CoreDataHelpers.viewContext

    convenience init(concert: Concert) {
        self.init()
        self.concert = concert
        translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()
    }

    private func setupSubviews() {
        textView = setupTextView()
        textView.text = concert.notes

        textView.fill(parent: self)
    }

    func saveNotes() {
        if textView.text.isEmpty {
            concert?.notes = nil
        } else {
            concert.notes = textView.text
        }
        context.saveIt()
    }

    private func setupTextView() -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        textView.text = concert?.notes
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self

        return textView
    }

}

extension ConcertNotesPartial: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        saveNotes()
    }
}
