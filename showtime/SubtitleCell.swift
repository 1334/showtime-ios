//
//  SubtitleCell.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 11/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class SubtitleCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
    }

    private func setupCell() {
        textLabel?.style(Theme.Styles.bold.style)
        detailTextLabel?.style(Theme.Styles.small.style)
    }
}
