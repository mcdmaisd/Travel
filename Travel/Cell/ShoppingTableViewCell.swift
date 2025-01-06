//
//  ShoppingTableViewCell.swift
//  Travel
//
//  Created by ilim on 2025-01-03.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {
    
    @IBOutlet private var todoLabel: UILabel!
    @IBOutlet private(set) var statusChangebuttons: [UIButton]!
    
    static let id = getId()

    override func awakeFromNib() {
        contentView.tintColor = .black
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configureCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let inset: CGFloat = 5
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0))
    }
    
    private func configureCell() {
        todoLabel.attributedText = nil
        todoLabel.text = nil
        todoLabel.textColor = .black
        todoLabel.font = .systemFont(ofSize: TravelConstants.systemfontSize)
        
        statusChangebuttons.forEach { $0.isSelected = false }
        statusChangebuttons[1].isUserInteractionEnabled = true
    }
        
    private func configureUI() {
        contentView.layer.cornerRadius = TravelConstants.cornerRadius
        contentView.backgroundColor = .lightGray
        
        todoLabel.font = .systemFont(ofSize: TravelConstants.systemfontSize)

        for (i, button) in statusChangebuttons.enumerated() {
            configureButton(i, button)
        }
    }
    
    private func configureButton(_ i: Int, _ button: UIButton) {
        var config = UIButton.Configuration.plain()
        config.baseBackgroundColor = .clear
        button.configuration = config
        button.configurationUpdateHandler = { btn in
            switch btn.state {
            case .selected:
                btn.configuration?.image = UIImage(systemName: TravelConstants.imageNames[i] + TravelConstants.selectedSuffix)
            default :
                btn.configuration?.image = UIImage(systemName: TravelConstants.imageNames[i])
            }
        }
    }
    
    func configureData(_ row: Int, _ todo: String) {
        statusChangebuttons.forEach { $0.tag = row}
        todoLabel.tag = row
        todoLabel.text = todo
    }
    
    func isDone() {
        todoLabel.attributedText = todoLabel.text?.strikeThrough()
        todoLabel.textColor = .gray
        
        statusChangebuttons[0].isSelected = true
        statusChangebuttons[1].isSelected = false
        statusChangebuttons[1].isUserInteractionEnabled = false
    }
    
    func isPrimary() {
        statusChangebuttons[1].isSelected = true
        todoLabel.font = .boldSystemFont(ofSize: TravelConstants.boldSize)
    }
}
