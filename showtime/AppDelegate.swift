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
    var app: App?
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

        if let window = window {
            app = App(window: window)
        }

//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

        return true
    }
}
