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
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        let longSide = [imageWidth,imageHeight].max()!
        let scale = 512 / longSide
        let rect = CGRect(x: 0, y: 0, width: imageWidth * scale, height: imageHeight * scale)

        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
