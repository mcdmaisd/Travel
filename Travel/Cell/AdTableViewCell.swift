//
//  AdTableViewCell.swift
//  Travel
//
//  Created by ilim on 2025-01-03.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    @IBOutlet private var uiview: UIView!
    @IBOutlet private var adLabel: UILabel!
    
    private let colors: [UIColor] = [.systemMint, .systemPink, .systemBlue, .systemCyan, .systemBrown, .systemOrange]
    static let id = getId()
    
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
        adLabel.numberOfLines = TravelConstants.numberOfLines
    }
    
    func configureData(_ item: Travel) {
        adLabel.text = item.title
    }
}
