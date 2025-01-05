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
        contentView.layer.cornerRadius = 10
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
        uiview.layer.cornerRadius = 10
        uiview.backgroundColor = .white
    }
    
    private func configureLabel() {
        adLabel.font = .boldSystemFont(ofSize: 20)
        adLabel.textAlignment = .center
        adLabel.adjustsFontSizeToFitWidth = true
        adLabel.numberOfLines = 0
    }
}
