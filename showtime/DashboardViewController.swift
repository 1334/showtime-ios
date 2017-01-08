//
//  DashboardViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 06/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class DashboardViewContrller: ShowtimeBaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var upcomingShowsTableView: UITableView!
    @IBOutlet weak var recentShowsTableView: UITableView!
    @IBOutlet weak var upcomingShowsLabel: UILabel!
    @IBOutlet weak var recentShowsLabel: UILabel!

    var upcomingShows = [Concert]()
    var recentShows = [Concert]()
    var didSelect: (Concert) -> () = { _ in }
    let context = CoreDataStack.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        FirstRun().dialog(presenter: self) {
            self.reloadData()
        }

        setupLabels()
        setupTableViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
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

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            var concert: Concert
            if tableView == upcomingShowsTableView {
                concert = upcomingShows[indexPath.row]
                upcomingShows.remove(at: indexPath.row)
            } else {
                concert = recentShows[indexPath.row]
                recentShows.remove(at: indexPath.row)
            }
            context.delete(concert)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            context.saveIt()
        }
    }

    private func reloadData() {
        upcomingShows = Concert.upcoming()
        recentShows = Concert.recent()

        upcomingShowsTableView.reloadData()
        recentShowsTableView.reloadData()
    }

    private func setupLabels() {
        upcomingShowsLabel.style(Theme.Styles.title.style)
        recentShowsLabel.style(Theme.Styles.title.style)
    }

    private func setupTableViews() {
        let nib = UINib(nibName: "ConcertCell", bundle: nil)
        upcomingShowsTableView.register(nib, forCellReuseIdentifier: "concertCell")
        recentShowsTableView.register(nib, forCellReuseIdentifier: "concertCell")
        upcomingShowsTableView.estimatedRowHeight = CGFloat(Theme.Constants.estimatedRowHeight.rawValue)
        recentShowsTableView.estimatedRowHeight = CGFloat(Theme.Constants.estimatedRowHeight.rawValue)
    }
}
