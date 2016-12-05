//
//  ConcertSetlistView.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 05/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class ConcertSetlistPartial: UIView {
    var concert: Concert!
    private var textView = UITextView()

    convenience init(concert: Concert) {
        self.init()
        self.concert = concert
        translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()
    }

    private func setupSubviews() {
        textView.backgroundColor = UIColor(red: 0.95, green: 0.8, blue: 1, alpha: 1)
        textView.isEditable = false
        if concert.setlistUpdatedAt == nil {
            retrieveSetlist()
        } else {
            textView.text = concert.setlist
            textView.text.append("\n\n updated at: \(concert.setlistUpdatedAt)")
        }

        textView.textAlignment = .center
        textView.translatesAutoresizingMaskIntoConstraints = false

        textView.fill(parent: self)
    }

    private func retrieveSetlist() {
        SetlistFmStore().searchSetlist(artist: concert.artist.name, date: concert.date) { result in
            switch result {
            case let .success(setlist):
                DispatchQueue.main.sync {
                    self.concert.setlist = setlist.setlist.map { $0.joined(separator: "\n") }.joined(separator: "\n\n")
                    self.concert.setlistUpdatedAt = setlist.updatedAt
                    try? CoreDataHelpers.viewContext.save()
                    self.setupSubviews()
                }
            default:
                DispatchQueue.main.sync {
                    self.textView.text = "setlist not found"
                }
            }
        }
    }
}
