//
//  DashboardViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 06/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class DashboardViewContrller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var upcomingShowsTableView: UITableView!
    @IBOutlet weak var recentShowsTableView: UITableView!
    var upcomingShows = [Concert]()
    var recentShows = [Concert]()
    var didSelect: (Concert) -> () = { _ in }

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "ConcertCell", bundle: nil)
        upcomingShowsTableView.register(nib, forCellReuseIdentifier: "concertCell")
        upcomingShowsTableView.dataSource = self
        upcomingShowsTableView.delegate = self
        recentShowsTableView.register(nib, forCellReuseIdentifier: "concertCell")
        recentShowsTableView.dataSource = self
        recentShowsTableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        upcomingShows = Concert.upcoming()
        recentShows = Concert.recent()

        upcomingShowsTableView.reloadData()
        recentShowsTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == upcomingShowsTableView ? upcomingShows.count : recentShows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let concerts = tableView == upcomingShowsTableView ? upcomingShows : recentShows
        let concert = concerts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "concertCell", for: indexPath) as! ConcertCell

        cell.artistLabel.text = concert.artist.name
        cell.venueLabel.text = concert.venue.name
        cell.dateLabel.text = concert.formattedDate

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let concerts = tableView == upcomingShowsTableView ? upcomingShows : recentShows
        let concert = concerts[indexPath.row]
        didSelect(concert)
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
}
