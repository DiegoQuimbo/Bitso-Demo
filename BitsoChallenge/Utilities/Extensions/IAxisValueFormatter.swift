//
//  IAxisValueFormatter.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/26/21.
//

import Foundation
import Charts

class DataAxisValueFormatter: NSObject {
    var dates: [Date]
    
    init(dates: [Date]) {
        self.dates = dates
    }
}

extension DataAxisValueFormatter: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let i = Int(value)
        return dates[i].stringDateWithFormat("MM-dd")
    }
}
