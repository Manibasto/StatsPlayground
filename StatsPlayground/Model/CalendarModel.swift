//
//  CalendarModel.swift
//  HorizontalCalendarPicker
//
//  Created by Michal Majchrzycki on 28.02.2017.
//  Copyright © 2017 Michal Majchrzycki. All rights reserved.
//

import Foundation

protocol CalendarDelgate {
    
}

class CalendarPicker {
    //MARK: - Declarations
    var delegate: CalendarDelgate?
    
    func arrayOfDates() -> Array<String> {
        
        let numberOfYears: Int = 8
        let date = "2012"
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "Y"
        let date1 = formatter.date(from: date)
        let startDate = date1
        let calendar = Calendar.current
        var offset = DateComponents()
        var dates: [String] = [formatter.string(from: startDate!)]
        
        for i in 1..<numberOfYears {
            offset.year = i
            let nextDay: Date? = calendar.date(byAdding: offset,to: startDate!)
            let nextDayString = formatter.string(from: nextDay!)
            dates.append(nextDayString)
        }
        return dates as Array
    }
}
