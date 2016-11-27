//
//  ConcertNotesView.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 26/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class ConcertNotesView : UIView {
    var concert: Concert!
    var textView: UITextView!

    convenience init(concert: Concert) {
        self.init(frame: CGRect.zero)
        self.concert = concert
        setupSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        textView = setupTextView()
        textView.text = concert.notes
        addSubview(textView)

        textView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        textView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }

    func saveNotes() {
        if textView.text.isEmpty {
            concert?.notes = nil
        } else {
            concert.notes = textView.text
        }
        try! CoreDataHelpers.viewContext.save()
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

extension ConcertNotesView : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        saveNotes()
    }
}
