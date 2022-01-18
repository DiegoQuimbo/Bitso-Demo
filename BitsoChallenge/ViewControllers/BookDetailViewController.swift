//
//  BookDetailViewController.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/25/21.
//

import UIKit
import Charts

class BookDetailViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var askLabel: UILabel!
    @IBOutlet weak var bidLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var spreadLabel: UILabel!
    @IBOutlet weak var contentChartView: UIView!
    
    // Public vars
    var viewModel: BookDetailViewModel?
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .black
        chartView.rightAxis.enabled = false
        chartView.leftAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.leftAxis.setLabelCount(10, force: false)
        chartView.leftAxis.labelTextColor = .white
        chartView.leftAxis.axisLineColor = .white
        chartView.leftAxis.labelPosition = .outsideChart
        chartView.leftAxis.drawGridLinesEnabled = false
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .white
        chartView.xAxis.drawGridLinesEnabled = false
        
        chartView.legend.form = .none
        return chartView
    }()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callGetTickerService()
        callGetTradesService()
    }
}

// MARK: - Private Finctions
private extension BookDetailViewController {
    func loadTickerInView() {
        bookTitleLabel.text = viewModel?.bookTitle
        bidLabel.text = viewModel?.bid
        askLabel.text = viewModel?.ask
        lowLabel.text = viewModel?.low
        highLabel.text = viewModel?.high
        volumeLabel.text = viewModel?.volume
        spreadLabel.text = viewModel?.spread
    }
    
    func buildChart() {
        contentChartView.addSubview(lineChartView)
        lineChartView.frame = contentChartView.bounds
        setDataChart()
    }
    
    func setDataChart() {
        guard let chartData = viewModel?.getDataChart() else {
            contentChartView.isHidden = true
            return
        }
        lineChartView.xAxis.valueFormatter = DataAxisValueFormatter(dates: viewModel?.chartDates ?? [])
        lineChartView.data = chartData
    }
}

// MARK: - Private methods Services
private extension BookDetailViewController {
    func callGetTickerService() {
        showProgressView(view: view)
        viewModel?.getTickerService(completion: { [unowned self] success in
            self.hideProgressView()
            if success {
                loadTickerInView()
            } else {
                showAlert(title: "Error", message: "There is an error getting the Book")
            }
        })
    }
    
    func callGetTradesService() {
        viewModel?.getTradeService(completion: { [unowned self] success in
            if success {
                buildChart()
            }
        })
    }
}
