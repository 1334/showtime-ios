//
//  NewDialog.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 08/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

final class FirstRun {
    let context = CoreDataHelpers.viewContext

    func dialog(presenter: UIViewController) {
        if !UserDefaults.standard.bool(forKey: "FirstRunComplete") {
            let alert = firstRunMessage()
            presenter.present(alert, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "FirstRunComplete")
        }
    }

    private func firstRunMessage() -> UIAlertController {
        let alert = UIAlertController(title: "New Run", message: "We've found that there are no shows entered, what do you want to do?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Load Sample Data", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Add Concert", style: .default) { action in
            guard let rootVC = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController else { return }
            rootVC.selectedIndex = 4
        })
        alert.addAction(UIAlertAction(title: "Nothing", style: .cancel, handler: nil))

        return alert
    }

    private func createArtists() {
        _ = [ Artist(name: "David Bowie", mbid: "5441c29d-3602-4898-b1a1-b77fa23b8e50"),
            Artist(name: "Iggy Pop", mbid: "f37b3f31-b1f8-4b88-8cb5-b34f709b17d7"),
            Artist(name: "Iggy and The Stooges", mbid: "1253e5e9-eaa7-4ce6-81b8-09725e8cee43"),
            Artist(name: "Nine Inch Nails", mbid: "b7ffd2af-418f-4be2-bdd1-22f8b48613da"),
            Artist(name: "Sex Pistols", mbid: "e5db18cb-4b1f-496d-a308-548b611090d3"),
            Artist(name: "Alice Cooper", mbid: "4d7928cd-7ed2-4282-8c29-c0c9f966f1bd"),
            Artist(name: "Swans", mbid: "3285dc48-9505-469d-ad8a-bdf2d3dba632"),
            Artist(name: "Nick Cave & The Bad Seeds", mbid: "172e1f1a-504d-4488-b053-6344ba63e6d0"),
            Artist(name: "Peter Murphy", mbid: "b78346af-e3ce-4b36-a0d5-032414de8a27")]
        context.saveIt()
    }
}
