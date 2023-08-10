//
//  HandleDate.swift
//  NeedleApp
//
//  Created by jpcm2 on 09/08/23.
//

import Foundation

// Credits: Thaxz https://github.com/thaxz

class HandleDate {
    
    static let months = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
    
    static let numberOfDaysPerMonth: [Int: Int] = [
        1: 31, 2: 28, 3: 31, 4: 30, 5: 31, 6: 30, 7: 31, 8: 31, 9: 30, 10: 31, 11: 30, 12: 31
    ]
    
    static func handleDate(date: String) -> String {
        let splittedDate = date.split(separator: "-")
        let day = splittedDate[2].prefix(2)
        guard let monthNumber = Int(splittedDate[1]) else { return "" }
        let month = months[monthNumber - 1]
        let ret = "\(month) \(day)"
        return String(ret)
    }
}