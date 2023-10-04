//
//  HandleDate.swift
//  NeedleApp
//
//  Created by jpcm2 on 09/08/23.
//

import Foundation

// Credits: Thaxz https://github.com/thaxz

class HandleDate {
    
    static let months = ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"]
    
    static let numberOfDaysPerMonth: [Int: Int] = [
        1: 31, 2: 28, 3: 31, 4: 30, 5: 31, 6: 30, 7: 31, 8: 31, 9: 30, 10: 31, 11: 30, 12: 31
    ]
    
    static func handleDate(date: String) -> String {
        let splittedDate = date.split(separator: "-")
        let day = splittedDate[2].prefix(2)
        guard let monthNumber = Int(splittedDate[1]) else { return "" }
        let month = months[monthNumber - 1]
        let ret = "\(day) \(month)"
        return String(ret)
    }
    
    static func formatDateWithTime(dateInput: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateInput) {
            dateFormatter.dateFormat = "dd/MM/yyyy - HH:mm:ss"
            dateFormatter.timeZone = TimeZone.current
            
            let returnTimeString = dateFormatter.string(from: date)
            return returnTimeString
        } else {
            return "-"
        }
    }
    
    static func formatDateWithoutTime(dateInput: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateInput) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter.timeZone = TimeZone.current
            
            let returnTimeString = dateFormatter.string(from: date)
            return returnTimeString
        } else {
            return "-"
        }
    }
    
    static func sortArrayOfDates(dateArr: [TaskModel]) -> [TaskModel]{
        
        print("unsorted", dateArr)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let sortedArray = dateArr.sorted {dateFormatter.date(from: $0.updated_at)! > dateFormatter.date(from: $1.updated_at)!}
        
        print("sorted", sortedArray)
        
        return sortedArray
    }
    
}
