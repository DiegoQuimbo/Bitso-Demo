//
//  BookDetailViewModel.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/25/21.
//

import Foundation
import Charts

final class BookDetailViewModel {
    // Private Vars
    private var _book: Book?
    private var _trades: [Trade]? = []
    private var _chartDates: [Date] = []
    
    // MARK: - Init
    init(book: Book?) {
        _book = book
    }
    
    // MARK: - Public Vars
    var bookTitle: String {
        return _book?.title ?? ""
    }
    
    var bid: String {
        return "Bid: \(_book?.ticker?.bid ?? "-")"
    }
    
    var ask: String {
        return "Ask: \(_book?.ticker?.ask ?? "-")"
    }
    
    var low: String {
        return "Low: \(_book?.ticker?.low ?? "-")"
    }
    
    var high: String {
        return "High: \(_book?.ticker?.high ?? "-")"
    }
    
    var volume: String {
        return "Volume: \(_book?.ticker?.volume ?? "-")"
    }
    
    var chartDates: [Date] {
        return _chartDates
    }
    
    var spread: String? {
        // The spread it's the percentage difference between bid and ask price
        guard let ask = Double(_book?.ticker?.ask ?? "0"),
              let bid = Double(_book?.ticker?.bid ?? "0") else {
            return "Spread: -"
        }
        
        let difference =  ask - bid
        let spread =  (difference / bid) * 100
        
        // Round percentage
        return "Spread: % \(String(format: "%.2f", spread))"
    }
    
    // MARK: - Public Functions
    func getDataChart() -> LineChartData? {
        let chartData = buildChartData()
        if chartData.count == 0 {
            return nil
        }
        
        let chartValues = LineChartDataSet(entries: chartData)
        chartValues.drawCirclesEnabled = false
        chartValues.lineWidth = 3
        chartValues.setColor(.green)
        
        let data = LineChartData(dataSet: chartValues)
        data.setDrawValues(false)
        return data
    }
    
    // MARK: - Private Functions
    private func buildChartData() -> [ChartDataEntry] {
        guard let tradeElements = _trades else { return [] }
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<tradeElements.count {
            _chartDates.append(tradeElements[i].date)
            
             let dataEntry = ChartDataEntry(x: Double(i), y: tradeElements[i].value ?? 0)
             dataEntries.append(dataEntry)
        }
        
        return dataEntries
    }
}


// MARK: - Call Network
extension BookDetailViewModel {
    // Get Ticker through cache service in order to avoid unnecessary API calls
    func getTickerService(completion :@escaping (_ success: Bool) -> ()) {
        guard let bookTitle = _book?.title else { return }
        TickerCache.shared.obtainTicker(bookTitle: bookTitle) { [weak self] ticker in
            self?._book?.ticker = ticker
            completion(ticker != nil)
        }
    }
    
    func getTradeService(completion :@escaping (_ success: Bool) -> ()) {
        guard let bookTitle = _book?.title else { return }
        BookServices.shared.getTrade(bookTitle: bookTitle) { [unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let trades):
                    _trades = trades
                    completion(true)
                case .failure(_):
                    completion(false)
                }
            }
        }
    }
}
