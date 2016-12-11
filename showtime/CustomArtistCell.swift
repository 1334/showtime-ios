//
//  CustomArtistCell.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 09/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class CustomArtistCell: UITableViewCell {
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak private var artistLabel: UILabel!
    @IBOutlet weak private var explanationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        artistName.text = ""
        artistName.style(Theme.Styles.bold.style)
        explanationLabel.style(Theme.Styles.tiny.style)
    }
}
