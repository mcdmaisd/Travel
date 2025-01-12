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
    
    func stringToDateFormat(_ inputFormat: String, _ outputFormat: String) -> String {
        let formatter = DateFormatter()
        let date = stringToDate(inputFormat)
        formatter.dateFormat = outputFormat
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return formatter.string(from: date)
    }
    
    func stringToDate(_ format: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        let date = formatter.date(from: self)
        return date ?? Date()
    }
    
    func hasMatchedToPropertyValue(_ unicodePropertyValue: String) -> Bool {
        return self.range(of: "\\p{\(unicodePropertyValue)}", options: .regularExpression) != nil
    }
}
