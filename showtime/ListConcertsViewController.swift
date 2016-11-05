//
//  ListConcertsViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 02/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit


struct Concert: CustomStringConvertible {
    let artist: Artist
    let date: Date
    let venue: Venue

    var description: String { return "\(artist) live at \(venue) on \(formattedDate))" }
}

extension Concert {
    var formattedDate: String  {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df.string(from: date)
    }
}
extension Concert {
    init(artist: String, date: String, venue: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        self.artist = Artist(name: artist)
        self.date = dateFormatter.date(from: date)!
        self.venue = Venue(name: venue)
    }
}

struct Artist: CustomStringConvertible {
    let name: String

    var description: String { return name }
}

struct Venue: CustomStringConvertible {
    let name: String

    var description: String { return name }
}

class DateFormatters {
    static var dateParser: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df
    }
    static var mediumFormatDate: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }

    static var longFormatDate: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .long
        return df
    }
}

class ListConcertsViewController: UITableViewController {

    var concerts = [Concert]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //let som = Artist(name: "The Sisters of Mercy")
        //let bauhaus = Artist(name: "Bauhaus")
        //let db = Artist(name: "David Bowie")

        //let apolo = Venue(name: "Sala Apolo")
        //let s54 = Venue(name: "Studio 54")
        //let zeleste = Venue(name: "Zeleste")

        // concerts = [
        //    Concert(artist: som, date: Date.init(timeIntervalSinceNow: -3453436), venue: apolo),
        //    Concert(artist: bauhaus, date: Date.init(timeIntervalSinceNow: -8574436), venue: s54),
        //    Concert(artist: som, date: Date.init(timeIntervalSinceNow: -453452), venue: s54),
        //    Concert(artist: db, date: Date.init(timeIntervalSinceNow: -553450002), venue: zeleste)
        //]
        concerts = [
            Concert(artist: "Sisters of Mervy", date: "23/9/1993", venue: "Sala Apolo"),
            Concert(artist: "Bauhaus", date: "18/5/1983", venue: "Studio 54"),
            Concert(artist: "Sisters of Mervy", date: "11/9/2016", venue: "Palau Sant Jordi"),
            Concert(artist: "David Bowie", date: "8/1/2016", venue: "La Cova del Drac")

        ]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return concerts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "concertCell", for: indexPath)
        let concert = concerts[indexPath.row]

        cell.textLabel?.text = "\(concert.artist)"
        cell.detailTextLabel?.text = "\(concert.venue) - \(concert.formattedDate)"

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
