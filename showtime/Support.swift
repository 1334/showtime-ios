//
//  Support.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 07/11/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import Foundation

class DateFormatters {
    static var dateParser: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df
    }
    static var mediumFormatDate: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }

    static var longFormatDate: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .long
        return df
    }
}
