//
//  ConcertNotesView.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 26/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

class ConcertNotesView : UIView {
    var concert: Concert?

    convenience init(concert: Concert) {
        self.init(frame: CGRect.zero)
        self.concert = concert
        setupSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        addSubview(stack)
        stack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stack.widthAnchor.constraint(equalTo: widthAnchor).isActive = true

        if concert == nil {
            stack.addArrangedSubview(label(title: "No concert selected"))
        }
    }

    private func label(title: String) -> UILabel {
        let label = UILabel()
        label.text = title

        return label
    }

}
