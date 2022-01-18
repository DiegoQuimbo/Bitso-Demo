//
//  Routes.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/25/21.
//

import Foundation

struct URLs {
    
    static var baseURL : URL = URL(string: "https://api.bitso.com/")!
    static var baseBooksURL : URL = URL(string: "\(baseURL)v3/available_books/")!
    static var baseTickerURL : URL = URL(string: "\(baseURL)v3/ticker/")!
    static var baseTradeURL : URL = URL(string: "https://bitso.com/trade/")!
    
    struct Book {
        static let books = baseBooksURL
    }
    
    struct Ticker {
        static func tricker(bookTitle: String) -> URL {
            return URL(string: "\(baseTickerURL)?book=\(bookTitle)")!
        }
    }
    
    struct Trade {
        static func chart(bookTitle: String) -> URL {
            return URL(string: "\(baseTradeURL)chartJSON/\(bookTitle)/1month")!
        }
    }
}
