//
//  CityTableViewCell.swift
//  Travel
//
//  Created by ilim on 2025-01-03.
//

import UIKit
import Cosmos

class CityTableViewCell: UITableViewCell {

    @IBOutlet private var cityImageView: UIImageView!
    @IBOutlet private(set) var likeButton: UIButton!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var starview: CosmosView!
    @IBOutlet private var saveLabel: UILabel!

    static let id = getId()

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityImageView.image = nil
        likeButton.isSelected = false
        titleLabel.text = nil
        subtitleLabel.text = nil
        saveLabel.text = nil
    }
    
    private func configureUI() {
        configureImageView()
        configureButton(likeButton)
        configureTitleLabel()
        configureSubtitleLabel()
        configureStar()
        configureSaveLabel()
    }
    
    private func configureImageView() {
        cityImageView.layer.cornerRadius = TravelConstants.cornerRadius
        cityImageView.contentMode = .scaleToFill
    }

    private func configureButton(_ button: UIButton) {
        var config = UIButton.Configuration.plain()
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .red
        button.configuration = config
        button.configurationUpdateHandler = { btn in
            switch btn.state {
            case .selected:
                btn.configuration?.image = UIImage(systemName: TravelConstants.selectedLikeButton)
            default:
                btn.configuration?.image = UIImage(systemName: TravelConstants.normalLikeButton)
            }
        }
    }

    private func configureTitleLabel() {
        titleLabel.font = .boldSystemFont(ofSize: TravelConstants.boldSize)
        titleLabel.sizeToFit()
    }

    private func configureSubtitleLabel() {
        subtitleLabel.font = .systemFont(ofSize: TravelConstants.systemfontSize)
        subtitleLabel.textColor = .gray
        subtitleLabel.numberOfLines = 0
    }
    
    private func configureStar() {
        starview.settings.fillMode = .precise
        starview.settings.starMargin = 0
    }
    
    private func configureSaveLabel() {
        saveLabel.font = .systemFont(ofSize: 14)
        saveLabel.textColor = .lightGray
        saveLabel.sizeToFit()
    }
    
    func configureData(_ item: Travel, _ row: Int) {
        cityImageView.kf.setImage(with: URL(string: item.travel_image ?? ""))
        likeButton.tag = row
        likeButton.isSelected = item.like ?? false
        titleLabel.text = item.title
        subtitleLabel.text = item.description
        starview.rating = item.grade ?? 0
        saveLabel.text = "· 저장 \(item.save?.formatted() ?? "")"
    }    
}
