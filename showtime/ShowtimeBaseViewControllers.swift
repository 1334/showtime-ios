//
//  ShowtimeBaseViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 10/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class ShowtimeBaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.Colors.background.color
    }
}

class ShowtimeBaseTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.Colors.background.color
        tableView.estimatedRowHeight = CGFloat(Theme.Constants.estimatedRowHeight.rawValue)
    }
}

class ShowtimeBaseStaticTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.Colors.background.color
    }
}
