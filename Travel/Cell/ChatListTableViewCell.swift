//
//  ChatListTableViewCell.swift
//  Travel
//
//  Created by ilim on 2025-01-11.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {
    
    @IBOutlet private var lastChatDateLabel: UILabel!
    @IBOutlet private var lastChatLabel: UILabel!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var profileStackView: UIStackView!
    @IBOutlet private var profileImages: [UIImageView]!
    @IBOutlet private var lastStackView: UIStackView!
    
    static let id = getId()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImages.forEach { $0.image = nil }
        userNameLabel.text = nil
        lastChatLabel.text = nil
        lastChatDateLabel.text = nil
        lastStackView.isHidden = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileStackView.layoutIfNeeded()
        profileStackView.layer.cornerRadius = profileStackView.frame.width / 2
    }
    
    private func hideStackView() {
        if profileImages[2].image == nil {
            lastStackView.isHidden = true
        }
    }
    
    private func configureUI() {
        configureStackView()
        configureProfileImageView()
        configureNameLabel()
        configureDateLabel()
        configureChatLabel()
    }
    
    private func configureStackView() {
        profileStackView.layer.borderColor = UIColor.lightGray.cgColor
        profileStackView.layer.borderWidth = 1
        profileStackView.clipsToBounds = true
    }
    
    private func configureProfileImageView() {
        profileImages.forEach { $0.contentMode = .scaleAspectFit }
    }
    
    private func configureNameLabel() {
        userNameLabel.font = .boldSystemFont(ofSize: 16)
        userNameLabel.adjustsFontSizeToFitWidth = true
        userNameLabel.textColor = .black
        userNameLabel.textAlignment = .left
    }
    
    private func configureChatLabel() {
        lastChatLabel.font = .systemFont(ofSize: 16)
        lastChatLabel.textColor = .gray
        lastChatLabel.textAlignment = .left
    }
    
    private func configureDateLabel() {
        lastChatDateLabel.font = .systemFont(ofSize: 16)
        lastChatDateLabel.textColor = .lightGray
        lastChatDateLabel.textAlignment = .center
    }
    
    func configureData(_ data: ChatRoom) {
        for (i, imageName) in data.chatroomImage.enumerated() {
            profileImages[i].image = UIImage(named: imageName)
        }
        
        hideStackView()
        
        userNameLabel.text = data.chatroomName
        lastChatLabel.text = data.chatList.last?.message
        lastChatDateLabel.text = data.chatList.last?.date.stringToDateFormat(TravelConstants.chatDateInputForamt, TravelConstants.chatDateOutputForamt)
    }
}
