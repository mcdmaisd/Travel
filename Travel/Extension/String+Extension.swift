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
        formatter.dateFormat = "yyMMdd"
        guard let date = formatter.date(from: self) else {
            return "변환실패"
        }
        
        formatter.dateFormat = "yy년 MM월 dd일"
        let dateString = formatter.string(from: date)
        
        return dateString
    }
}
