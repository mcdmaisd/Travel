//
//  AdTableViewCell.swift
//  Travel
//
//  Created by ilim on 2025-01-03.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    @IBOutlet var uiview: UIView!
    @IBOutlet var adLabel: UILabel!
    
    private let colors: [UIColor] = [.systemMint, .systemPink, .systemBlue, .systemCyan, .systemBrown, .systemOrange]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
        
    private func configureUI() {
        contentView.layer.cornerRadius = TravelConstants.cornerRadius
        contentView.layer.masksToBounds = true
        setBackgroundColor()
        configureUIView()
        configureLabel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setBackgroundColor()
    }
    
    private func setBackgroundColor() {
        contentView.backgroundColor = colors.randomElement()
    }
    
    private func configureUIView() {
        uiview.layer.cornerRadius = TravelConstants.cornerRadius
        uiview.backgroundColor = .white
    }
    
    private func configureLabel() {
        adLabel.font = .boldSystemFont(ofSize: TravelConstants.boldSize)
        adLabel.textAlignment = .center
        adLabel.adjustsFontSizeToFitWidth = true
        adLabel.numberOfLines = 0
    }
}
