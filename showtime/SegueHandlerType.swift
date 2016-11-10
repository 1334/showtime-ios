//
//  Protocols.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 07/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

// MARK: SegueHandlerType
public protocol SegueHandlerType {
    associatedtype SegueIdentifier : RawRepresentable
}

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    public func segueIdentifier(for segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier)
            else { fatalError("Unknown segue: \(segue))") }
        return segueIdentifier
    }
}
