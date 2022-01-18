//
//  Date.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/26/21.
//

import Foundation

extension Date {
    func stringDateWithFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
