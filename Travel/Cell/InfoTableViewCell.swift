//
//  InfoTableViewCell.swift
//  Travel
//
//  Created by ilim on 2025-01-03.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet private var imageview: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!

    static let id = getId()

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
        titleLabel.numberOfLines = TravelConstants.numberOfLines
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
    
    func configureData(_ item: Magazine) {
        imageview.kf.setImage(with: URL(string: item.photo_image))
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        dateLabel.text = item.date.stringToDateFormat(TravelConstants.stringFormat, TravelConstants.dateStringFormat)
    }
}
