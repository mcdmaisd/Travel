//
//  TableViewController + Extension.swift
//  Travel
//
//  Created by ilim on 2025-01-03.
//

import UIKit

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func stringToDateFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = TravelConstants.stringFormat
        guard let date = formatter.date(from: self) else {
            return "변환실패"
        }
        
        formatter.dateFormat = TravelConstants.dateStringFormat
        let dateString = formatter.string(from: date)
        
        return dateString
    }
}
