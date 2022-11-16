//
//  Date+Random.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 16/11/2022.
//

import Foundation
extension Date {
    static func randomBetween(start: String, end: String, format: String = "yyyy-MM-dd") -> String {
        let date1 = Date.parse(start, format: format)
        let date2 = Date.parse(end, format: "yyyy-MM-dd'T'HH:mm:ssZ")
        return Date.randomBetween(start: date1, end: date2).dateString()
    }
    
    static func randomBetween(start: Date, end: Date) -> Date {
        var date1 = start
        var date2 = end
        if date2 < date1 {
            let temp = date1
            date1 = date2
            date2 = temp
        }
        let span = TimeInterval.random(in: date1.timeIntervalSinceNow...date2.timeIntervalSinceNow)
        return Date(timeIntervalSinceNow: span)
    }
    
    func dateString(_ format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    static func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: string)!
        return date
    }
}
