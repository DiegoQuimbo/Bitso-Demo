//
//  BookTableViewCell.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/25/21.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    // IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lastPriceLabel: UILabel!
    
    // Public vars
    private var _viewModel: BookTableCellViewModel?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(viewModel: BookTableCellViewModel) {
        _viewModel = viewModel
        titleLabel.text = _viewModel?.title
        lastPriceLabel.text = "-"
        callGetTickerService()
    }
}

// MARK: - Private methods Services
private extension BookTableViewCell {
    func callGetTickerService() {
        _viewModel?.getTickerService(completion: { [unowned self] success in
            if success {
                lastPriceLabel.text = _viewModel?.lastPrice
            }
        })
    }
}
