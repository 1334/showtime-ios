//
//  UIElements.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 29/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

struct UIElements {
    static func errorAlert(title: String, message: String, presenter: UIViewController, callback: @escaping (UIAlertAction) -> Void = { _ in }) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: callback)
        alert.addAction(action)

        presenter.present(alert, animated: true, completion: nil)
    }

    static func backButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
}

extension UIView {
    func fill(parent: UIView) {
        parent.addSubview(self)
        self.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: parent.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: parent.heightAnchor).isActive = true
    }
}

extension Date {
    static var yesterday: Date {
        return Date(timeIntervalSinceNow: -86400)
    }
}
