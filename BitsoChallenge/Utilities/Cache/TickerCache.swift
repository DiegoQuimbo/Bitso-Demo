//
//  TickerCache.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/25/21.
//

import Foundation

final class TickerCache {
    var session = URLSession.shared
    var cache: NSCache<NSString, Ticker> = NSCache()
    
    static let shared: TickerCache = {
        return TickerCache()
    }()
    
    func obtainTicker(bookTitle: String, completionHandler: @escaping (Ticker?) -> ()) {
        if let ticker = self.cache.object(forKey: bookTitle as NSString) {
            DispatchQueue.main.async {
                completionHandler(ticker)
            }
        } else {
            BookServices.shared.getTicker(bookTitle: bookTitle) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let ticker):
                        if let tickerObj = ticker {
                            self.cache.setObject(tickerObj, forKey: bookTitle as NSString)
                        }
                        completionHandler(ticker)
                    case .failure(_):
                        completionHandler(nil)
                    }
                }
            }
        }
    }
}
