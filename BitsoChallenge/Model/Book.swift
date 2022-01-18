//
//  Book.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/25/21.
//

struct Book {
    let title: String
    var ticker: Ticker?
    
    init(from decoder: Decoder) throws {
        let bookContainer = try decoder.container(keyedBy: BookKeys.self)
        title = try bookContainer.decode(String.self, forKey: .title)
    }
}

struct BookList: Decodable {
    let payload : [Book]
}

extension Book: Decodable {
    enum BookKeys: String, CodingKey {
        case title = "book"
    }
}
