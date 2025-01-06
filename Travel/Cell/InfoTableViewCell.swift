//
//  InfoTableViewCell.swift
//  Travel
//
//  Created by ilim on 2025-01-03.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet var imageview: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageview.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        dateLabel.text = nil
    }
    
    private func configureUI() {
        configureImageView()
        configureTitleLabel()
        configureSubTitleLabel()
        configureDateLabel()
    }
    
    private func configureImageView() {
        imageview.layer.cornerRadius = TravelConstants.cornerRadius
        imageview.contentMode = .scaleToFill
    }
    
    private func configureTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: TravelConstants.boldSize)
        titleLabel.textAlignment = .left
    }
    
    private func configureSubTitleLabel() {
        subtitleLabel.textColor = .lightGray
        subtitleLabel.textAlignment = .left
    }

    private func configureDateLabel() {
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right
    }
}
