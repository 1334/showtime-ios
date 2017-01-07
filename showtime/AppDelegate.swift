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
    var app: AppNavigation?
    lazy var container: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Showtime")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            // if we can't load the persisten store we better crash early, as there's nothing to do.
            if let error = error as NSError? {
                if let rvc = self.window?.rootViewController {
                    UIElements.errorAlert(title: "Couldn't load the Persistent Store", message: "Unresolved error \(error), \(error.userInfo)", presenter: rvc)
                }
                fatalError("Couldn't load the Persistent Store.\nUnresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        if let window = window {
            app = AppNavigation(window: window)
        }

//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

        return true
    }
}
