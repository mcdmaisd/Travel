//
//  OtherChatTableViewCell.swift
//  Travel
//
//  Created by ilim on 2025-01-11.
//

import UIKit

class OtherChatTableViewCell: UITableViewCell {

    @IBOutlet var chatBubble: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var chatLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    
    static let id = getId()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    private func configureUI() {
        configureChatLabel()
        configureDateLabel()
        configureNameLabel()
        configureProfileImageView()
        configureChatBubble()
    }
    
    private func configureNameLabel() {
        nameLabel.textAlignment = .left
        nameLabel.font = .boldSystemFont(ofSize: 16)
    }
    
    private func configureProfileImageView() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = TravelConstants.borderWidth
        profileImageView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func configureChatBubble() {
        chatBubble.layer.cornerRadius = TravelConstants.cornerRadius
        chatBubble.layer.borderWidth = TravelConstants.borderWidth
        chatBubble.layer.borderColor = UIColor.black.cgColor
    }

    private func configureChatLabel() {
        chatLabel.font = .systemFont(ofSize: 20)
        chatLabel.textAlignment = .left
    }

    private func configureDateLabel() {
        dateLabel.textColor = .gray
    }
    
    func configureData(_ item: Chat) {
        profileImageView.image = UIImage(named: item.user.rawValue)
        nameLabel.text = item.user.rawValue
        chatLabel.text = item.message
        dateLabel.text = item.date.stringToDateFormat(TravelConstants.chatDateInputForamt, TravelConstants.chatBubbleDateFormat)
    }
}
