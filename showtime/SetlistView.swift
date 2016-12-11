//
//  SetlistView.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 09/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class SetlistView: UIView {
    @IBOutlet weak var setlistText: UITextView!
    @IBOutlet weak var updatedAtText: UILabel!
    @IBOutlet weak var refreshSetlist: UIButton!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.8) {
            sender.transform = sender.transform.rotated(by: .pi)
            sender.transform = sender.transform.rotated(by: .pi)
        }
    }

    override func awakeFromNib() {
        setlistText.text = ""
        updatedAtText.text = ""
        updatedAtText.style(Theme.Styles.tiny.style)
    }
}
