//
//  DateFormatter+Extension.swift
//  SeSACWeek4_T2
//
//  Created by ez on 7/20/25.
//

import Foundation

extension String {
    func convertDateFormat(innerDateFormat: String, outerDateFormat: String, locale: Locale = .current) -> String {
        
        let innerDateFormatter = DateFormatter()
        innerDateFormatter.dateFormat = innerDateFormat
        let innerDate = innerDateFormatter.date(from: self)
        
        let outerDateFormatter = DateFormatter()
        outerDateFormatter.dateFormat = outerDateFormat
        outerDateFormatter.locale = locale
        let outerDateString = outerDateFormatter.string(from: innerDate ?? Date.now)
        
        return outerDateString
    }
}
