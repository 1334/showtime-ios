//
//  AppDelegate.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 24/09/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var container: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Showtime")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        if try! container.viewContext.count(for: Concert.sortedFetchRequest) > 0 {
            addTestData()
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    private func addTestData() {
        let artists = ["Iggy Pop", "Iggy and the Stooges", "Bauhaus", "David Bowie", "Leonard Cohen", "The Sound"]
        let venues = ["Wiskey A Go Go", "La Cova del Drac", "Zeleste", "O2 Arena", "Sala Apolo"]
        let years = Array(1985...2016)
        let months = Array(1...12)
        let days = Array(1...28)
        for _ in 1...100 {
            _ = Concert(artist: artists.random(),
                    date: "\(days.random())/\(months.random())/\(years.random())",
                venue: venues.random())
        }
        try! container.viewContext.save()
    }

}

extension Array {
    func random() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
