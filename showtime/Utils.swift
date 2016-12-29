//
//  Network.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 10/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import SystemConfiguration
import UIKit

final class Utils {
    class func isInternetAvailable() -> Bool {
        let networkReachability = Reachability.forInternetConnection()
        let networkStatus = networkReachability?.currentReachabilityStatus()

        return !(networkStatus == NotReachable)
    }

    class func resizeImage(_ image: UIImage) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 128, height: 128)
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
