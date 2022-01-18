//
//  BookService.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/25/21.
//

import Foundation

struct BookServices {
    static let shared = BookServices()
    
    
    let postSession = URLSession(configuration: .default)
    
    func getBooks(_ completion: @escaping (Result<[Book]>) -> ()) {
        do{
            let request = try HTTPNetworkRequest.configureHTTPRequest(url: URLs.Book.books, method: .get)
            
            postSession.dataTask(with: request) { (data, res, err) in
                if let response = res as? HTTPURLResponse, let unwrappedData = data {
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        let result = try? JSONDecoder().decode(BookList.self, from: unwrappedData)
                        completion(Result.success(result?.payload ?? []))
                    case .failure:
                        completion(Result.failure(HTTPNetworkError.decodingFailed))
                    }
                }
            }.resume()
        }catch{
            
            completion(Result.failure(HTTPNetworkError.badRequest))
        }
    }
    
    func getTicker(bookTitle: String, _ completion: @escaping (Result<Ticker?>) -> ()) {
        do{
            let request = try HTTPNetworkRequest.configureHTTPRequest(url: URLs.Ticker.tricker(bookTitle: bookTitle), method: .get)
            
            postSession.dataTask(with: request) { (data, res, err) in
                if let response = res as? HTTPURLResponse, let unwrappedData = data {
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        let result = try? JSONDecoder().decode(TickerResponse.self, from: unwrappedData)
                        completion(Result.success(result?.payload))
                    case .failure:
                        completion(Result.failure(HTTPNetworkError.decodingFailed))
                    }
                }
            }.resume()
        }catch{
            
            completion(Result.failure(HTTPNetworkError.badRequest))
        }
    }
    
    func getTrade(bookTitle: String, _ completion: @escaping (Result<[Trade]?>) -> ()) {
        do{
            let request = try HTTPNetworkRequest.configureHTTPRequest(url: URLs.Trade.chart(bookTitle: bookTitle), method: .get)
            
            postSession.dataTask(with: request) { (data, res, err) in
                if let response = res as? HTTPURLResponse, let unwrappedData = data {
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        let result = try? JSONDecoder().decode([Trade].self, from: unwrappedData)
                        completion(Result.success(result))
                    case .failure:
                        completion(Result.failure(HTTPNetworkError.decodingFailed))
                    }
                }
            }.resume()
        }catch{
            
            completion(Result.failure(HTTPNetworkError.badRequest))
        }
    }
}
