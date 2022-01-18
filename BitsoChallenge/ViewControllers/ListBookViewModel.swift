//
//  ListBookViewModel.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/25/21.
//

import Foundation

final class ListBookViewModel {
    //Private Vars
    private var _books: [Book] = []
    private var _bookSelected: Book?
    
    // MARK: - Public Vars
    var books: [Book] {
        return _books
    }
    
    // MARK: - Public Functions
    func setBookSelected(book: Book) {
        _bookSelected = book
    }
    
    func getBookDetailViewModel() -> BookDetailViewModel? {
        return BookDetailViewModel(book: _bookSelected)
    }
}

// MARK: - Call Network
extension ListBookViewModel {
    
    // Call get books service API
    func getBooksService(completion :@escaping (_ success: Bool) -> ()) {
        BookServices.shared.getBooks { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let books):
                    self._books = books
                    completion(true)
                case .failure(_):
                    completion(false)
                }
            }
        }
    }
}
