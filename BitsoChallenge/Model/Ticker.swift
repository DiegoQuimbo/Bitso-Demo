//
//  Ticker.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/25/21.
//

class Ticker: Decodable {
    var book: String?
    var volume: String?
    var high: String?
    var lastPrice: String?
    var low: String?
    var vwap: String?
    var ask: String?
    var bid: String?
    var created_at: String?
    
    required init(from decoder: Decoder) throws {
        let tickerContainer = try decoder.container(keyedBy: TickerKeys.self)
        book = try tickerContainer.decode(String.self, forKey: .book)
        volume = try tickerContainer.decode(String.self, forKey: .volume)
        high = try tickerContainer.decode(String.self, forKey: .high)
        lastPrice = try tickerContainer.decode(String.self, forKey: .lastPrice)
        low = try tickerContainer.decode(String.self, forKey: .low)
        vwap = try tickerContainer.decode(String.self, forKey: .vwap)
        ask = try tickerContainer.decode(String.self, forKey: .ask)
        bid = try tickerContainer.decode(String.self, forKey: .bid)
        created_at = try tickerContainer.decode(String.self, forKey: .created_at)
    }
}

extension Ticker {
    enum TickerKeys: String, CodingKey {
        case book = "book"
        case volume = "volume"
        case high = "high"
        case lastPrice = "last"
        case low = "low"
        case vwap = "vwap"
        case ask = "ask"
        case bid = "bid"
        case created_at = "created_at"
    }
}

struct TickerResponse: Decodable {
    let payload : Ticker
}
