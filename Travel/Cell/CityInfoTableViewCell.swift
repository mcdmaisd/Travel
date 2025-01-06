//
//  CityInfoTableViewCell.swift
//  Travel
//
//  Created by ilim on 2025-01-06.
//

import UIKit
import Kingfisher

class CityInfoTableViewCell: UITableViewCell {
    
    @IBOutlet private var cityImageView: UIImageView!
    @IBOutlet private(set) var cityNameLabel: UILabel!
    @IBOutlet private var cityExplainLabel: UILabel!

    static let id = getId()

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityImageView.image = nil
        cityNameLabel.text = nil
        cityExplainLabel.text = nil
        cityNameLabel.textColor = .white
        cityExplainLabel.textColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
    }
    
    private func configureUI() {
        configureContentView()
        configureImageView()
        configureNameLabel()
        configureExplainLabel()
    }
    
    private func configureContentView() {
        contentView.layer.masksToBounds = true
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        contentView.layer.cornerRadius = TravelConstants.cornerRadius
    }
    
    private func configureImageView() {
        cityImageView.contentMode = .scaleToFill
    }
    
    private func configureNameLabel() {
        cityNameLabel.textColor = .white
        cityNameLabel.font = .boldSystemFont(ofSize: TravelConstants.boldSize)
        cityNameLabel.textAlignment = .right
    }
    
    private func configureExplainLabel() {
        cityExplainLabel.backgroundColor = .black.withAlphaComponent(0.6)
        cityExplainLabel.textColor = .white
    }
    
    private func changeWordColor(_ word: String) {
        let labels = [cityNameLabel, cityExplainLabel]
        
        for label in labels {
            let text = label?.text ?? ""
            let attributeString = NSMutableAttributedString(string: text)
            attributeString.addAttribute(.foregroundColor, value: UIColor.systemPink, range: (text as NSString).range(of: word))
            label?.attributedText = attributeString
        }
    }
    
    func configureData(_ info: City) {
        cityImageView.kf.setImage(with: URL(string: info.city_image))
        cityNameLabel.text = "\(info.city_name)\(TravelConstants.separator)\(info.city_english_name)"
        cityExplainLabel.text = info.city_explain
    }
    
    func setKeyword(_ text: String) {
        let englishName = cityNameLabel.text!.components(separatedBy: TravelConstants.separator).last
        let isKorean = text.hasMatchedToPropertyValue(TravelConstants.categoryName)
        let word = isKorean ? text : englishName ?? ""
        
        changeWordColor(word)
    }
}
