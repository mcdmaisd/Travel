//
//  MyChatTableViewCell.swift
//  Travel
//
//  Created by ilim on 2025-01-11.
//

import UIKit

class MyChatTableViewCell: UITableViewCell {

    @IBOutlet private var chatLabel: UILabel!
    @IBOutlet private var chatBubble: UIView!
    @IBOutlet private var dateLabel: UILabel!
    
    static let id = getId()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        configureChatLabel()
        configureDateLabel()
        configureChatBubble()
    }
    
    private func configureChatBubble() {
        chatBubble.layer.cornerRadius = TravelConstants.cornerRadius
        chatBubble.layer.borderWidth = TravelConstants.borderWidth
        chatBubble.layer.borderColor = UIColor.black.cgColor
        chatBubble.backgroundColor = .lightGray
    }

    private func configureChatLabel() {
        chatLabel.backgroundColor = .clear
        chatLabel.font = .systemFont(ofSize: 20)
        chatLabel.textAlignment = .left
    }

    private func configureDateLabel() {
        dateLabel.textColor = .gray
    }
    
    func configureData(_ item: Chat) {
        chatLabel.text = item.message
        dateLabel.text = item.date.stringToDateFormat(TravelConstants.chatDateInputForamt, TravelConstants.chatBubbleDateFormat)
    }

}
