//
//  ProgressView.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/25/21.
//

import UIKit

class ProgressView: UIView {
    // IBOutlet
    @IBOutlet var contentView: UIView!
    
    static let shared: ProgressView = {
        let instance = ProgressView()
        instance.initialize()
        return instance
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Private Methods
    private func initialize() {
        // Load Xib
        Bundle.main.loadNibNamed("\(Self.self)", owner: self, options: nil)
        backgroundColor = UIColor.clear
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
        
    }
    
    func showProgress(to view: UIView) {
        view.addSubview(self)
    }
    
    func hideProgress() {
        DispatchQueue.main.async {
            self.removeFromSuperview()
        }
    }
}
