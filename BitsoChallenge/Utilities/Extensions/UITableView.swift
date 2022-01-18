//
//  UITableView.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/25/21.
//

import UIKit

extension UITableView {

    func deselectSelectedRow(animated: Bool) {
        if let indexPathForSelectedRow = self.indexPathForSelectedRow {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }
}
