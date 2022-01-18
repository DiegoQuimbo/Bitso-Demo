//
//  ListBookViewController.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/25/21.
//

import UIKit
import RxSwift
import RxCocoa

class ListBookViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    // Private vars
    private let _viewModel = ListBookViewModel()
    private var _books = BehaviorRelay<[Book]>(value: [])
    private var _autoRefreshTimer: Timer?
    private let _disposeBag = DisposeBag()
    private enum BookListSegue: String {
        case ShowBookDetail
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRxTableView()
        setupPullRefresh()
        callGetBooksService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.deselectSelectedRow(animated: true)
        startAutoRefreshTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if _autoRefreshTimer != nil {
            _autoRefreshTimer?.invalidate()
            _autoRefreshTimer = nil
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == BookListSegue.ShowBookDetail.rawValue {
            let bookDetailController = segue.destination as! BookDetailViewController
            bookDetailController.viewModel = _viewModel.getBookDetailViewModel()
        }
    }
}

// MARK: - Private methods UI
private extension ListBookViewController {
    func setupPullRefresh () {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func setupRxTableView() {
        _books.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "BookCell", cellType: BookTableViewCell.self)) { (row, book, cell) in
                cell.configureCell(viewModel: BookTableCellViewModel(book: book))
            }.disposed(by: _disposeBag)
        
        tableView.rx.modelSelected(Book.self)
            .subscribe(onNext: { [unowned self] book in
                _viewModel.setBookSelected(book: book)
                performSegue(withIdentifier: BookListSegue.ShowBookDetail.rawValue, sender: nil)
            }).disposed(by: _disposeBag)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        _viewModel.getBooksService { [unowned self] success in
            refreshControl.endRefreshing()
            if success {
                _books.accept(self._viewModel.books)
            } else {
                showAlert(title: "Error", message: "There is an error refreshing the available Books")
            }
        }
    }
    
    func startAutoRefreshTimer() {
        _autoRefreshTimer =  Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { [unowned self] timer in
            callGetBooksService(withProgressView: false)
        }
    }
}

// MARK: - Private methods Services
private extension ListBookViewController {
    func callGetBooksService(withProgressView: Bool = true) {
        if withProgressView {
            showProgressView(view: view)
        }
        _viewModel.getBooksService { [unowned self] success in
            self.hideProgressView()
            if success {
                _books.accept(self._viewModel.books)
            } else {
                showAlert(title: "Error", message: "There is an error getting the available Books")
            }
        }
    }
}
