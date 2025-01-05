//
//  ShoppingTableViewCell.swift
//  Travel
//
//  Created by ilim on 2025-01-03.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {
    @IBOutlet var todoLabel: UILabel!
    @IBOutlet var statusChangebuttons: [UIButton]!
    
    private let imageNames = ["checkmark.square", "star"]
    private let selectedSuffix = ".fill"
    
    override func awakeFromNib() {
        contentView.tintColor = .black
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configureCell()
    }
    
    private func configureCell() {
        todoLabel.attributedText = nil
        todoLabel.text = nil
        todoLabel.textColor = .black
        todoLabel.font = .systemFont(ofSize: 16)
        
        statusChangebuttons.forEach { $0.isSelected = false }
        statusChangebuttons[1].isUserInteractionEnabled = true
    }
        
    private func configureUI() {
        todoLabel.font = .systemFont(ofSize: 16)

        for (i, button) in statusChangebuttons.enumerated() {
            configureButton(i, button)
        }
    }
    
    private func configureButton(_ i: Int, _ button: UIButton) {
        var config = UIButton.Configuration.plain()
        config.baseBackgroundColor = .clear
        button.configuration = config
        button.configurationUpdateHandler = { [self] btn in
            switch btn.state {
            case .selected:
                btn.configuration?.image = UIImage(systemName: imageNames[i] + selectedSuffix)
            default :
                btn.configuration?.image = UIImage(systemName: imageNames[i])
            }
        }
    }
}
