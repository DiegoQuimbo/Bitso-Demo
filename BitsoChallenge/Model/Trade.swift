//
//  Trade.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/25/21.
//

import Foundation

struct Trade {
    let date: Date
    var value: Double?
    
    init(from decoder: Decoder) throws {
        let tradeContainer = try decoder.container(keyedBy: TradeKeys.self)
        let dateStr = try tradeContainer.decode(String.self, forKey: .date)
        date = dateStr.dateWithFormat("yyyy-MM-dd") ?? Date()
        let valueStr = try tradeContainer.decode(String.self, forKey: .value)
        value = Double(valueStr)
    }
}


extension Trade: Decodable {
    enum TradeKeys: String, CodingKey {
        case date = "date"
        case value = "value"
    }
}
