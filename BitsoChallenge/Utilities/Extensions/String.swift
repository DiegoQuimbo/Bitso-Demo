//
//  String.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/26/21.
//

import Foundation

extension String {
    func dateWithFormat(_ format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.date(from:self)
    }
}
