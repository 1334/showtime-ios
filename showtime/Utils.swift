//
//  Network.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 10/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import SystemConfiguration

final class Utils {
    class func isInternetAvailable() -> Bool {
        let networkReachability = Reachability.forInternetConnection()
        let networkStatus = networkReachability?.currentReachabilityStatus()

        return !(networkStatus == NotReachable)
    }
}
