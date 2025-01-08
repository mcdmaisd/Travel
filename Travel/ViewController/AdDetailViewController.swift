//
//  AdDetailViewController.swift
//  Travel
//
//  Created by ilim on 2025-01-08.
//

import UIKit

class AdDetailViewController: UIViewController {

    @IBOutlet private var adLabel: UILabel!
    
    var adMessage: String?
    
    static let id = getId()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureAdLabel()
    }
    
    private func configureNavigationBar() {
        title = "광고 화면"
    }
    
    private func configureAdLabel() {
        adLabel.numberOfLines = TravelConstants.numberOfLines
        adLabel.font = .boldSystemFont(ofSize: TravelConstants.boldSize)
        adLabel.textAlignment = .center
        adLabel.text = adMessage ?? ""
    }
}
