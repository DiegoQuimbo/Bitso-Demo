//
//  BookTableCellViewModel.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/25/21.
//

final class BookTableCellViewModel {
    //Private Vars
    private var _book: Book?
    
    // MARK: - Init
    init(book: Book?) {
        _book = book
    }
    
    // MARK: - Public Vars
    var title: String {
        return "Title Book: \(_book?.title ?? "")"
    }
    
    var lastPrice: String {
        return "Last Price: \(_book?.ticker?.lastPrice ?? "")"
    }
}

// MARK: - Call Network
extension BookTableCellViewModel {
    // Call get ticker
    func getTickerService(completion :@escaping (_ success: Bool) -> ()) {
        guard let bookTitle = _book?.title else { return }
        TickerCache.shared.obtainTicker(bookTitle: bookTitle) { [weak self] ticker in
            self?._book?.ticker = ticker
            completion(ticker != nil)
        }
    }
}
