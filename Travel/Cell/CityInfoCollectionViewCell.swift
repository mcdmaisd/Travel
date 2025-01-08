//
//  CityInfoCollectionViewCell.swift
//  Travel
//
//  Created by ilim on 2025-01-08.
//

import UIKit
import Kingfisher

class CityInfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var cityImageView: UIImageView!
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var cityExplainLabel: UILabel!
    
    static let id = getId()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cityImageView.layer.cornerRadius = cityImageView.frame.size.width / 2
    }
    
    private func configureUI() {
        configureImageView()
        configureNameLabel()
        configureExplainLabel()
    }
    
    private func configureImageView() {
        cityImageView.contentMode = .scaleToFill
        cityImageView.clipsToBounds = true
    }
    
    private func configureNameLabel() {
        cityNameLabel.font = .boldSystemFont(ofSize: TravelConstants.boldSize)
        cityNameLabel.textAlignment = .center
        cityNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func configureExplainLabel() {
        cityExplainLabel.numberOfLines = TravelConstants.numberOfLines
        cityExplainLabel.textAlignment = .center
        cityExplainLabel.textColor = .lightGray
        cityExplainLabel.font = .systemFont(ofSize: TravelConstants.systemfontSize)
    }
    
    func configureData(_ item: City) {
        cityImageView.kf.setImage(with: URL(string: item.city_image))
        cityNameLabel.text = "\(item.city_name)\(TravelConstants.separator)\(item.city_english_name)"
        cityExplainLabel.text = item.city_explain
    }
}
