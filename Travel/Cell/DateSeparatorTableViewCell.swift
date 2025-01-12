//
//  DateSeparatorTableViewCell.swift
//  Travel
//
//  Created by ilim on 2025-01-12.
//

import UIKit

class DateSeparatorTableViewCell: UITableViewCell {

    @IBOutlet private var uiview: UIView!
    @IBOutlet private var dateLabel: UILabel!

    static let id = getId()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
    }
    
    private func configureUI() {
        configureUIView()
        configureDateLabel()
    }
    
    private func configureDateLabel() {
        dateLabel.textColor = .black
        dateLabel.textAlignment = .center
        dateLabel.sizeToFit()
    }
    
    private func configureUIView() {
        uiview.backgroundColor = .lightGray.withAlphaComponent(0.5)
        uiview.layer.cornerRadius = TravelConstants.cornerRadius
    }
    
    func configureData(_ date: String) {
        dateLabel.text = date
    }
}
