//
//  CellWithImage.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 11/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class CellWithImage: UITableViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var subtitleText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleText.style(Theme.Styles.bold.style)
        subtitleText.style(Theme.Styles.small.style)
    }
}
