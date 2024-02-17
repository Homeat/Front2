//
//  CalendarManager.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/02/17.
//

import Foundation
import UIKit

final class CalendarManager {
    
    private let calendar = Calendar.current
    private var nowCalendarDate = Date()
    private var calendarFormatter = CalendarDateFormatter()
    private(set) var yearMonths = [Date]()
    private(set) var monthDays = [[String]]()
    
    init() {
        self.setCalendar()
    }
    
    func getMonthsToString(section: Int) -> String {
        guard yearMonths.count > section else { return "" }
        
        let monthString = self.calendarFormatter.getYearMonthText(calendarDate: yearMonths[section])
        return monthString
    }
    
}

extension CalendarManager {
    func setCalendarData(for date: Date) {
        nowCalendarDate = date
        setYearMonth()
        setMonthDays()
    }
    func setCalendar() {
        let components = self.calendar.dateComponents([.year, .month], from: Date())
        self.nowCalendarDate = self.calendar.date(from: components) ?? Date()
        self.calendarFormatter.setCalendarComponent(calendar: self.calendar)
        self.setYearMonth()
        self.setMonthDays()
    }
    
    func setYearMonth() {
        self.yearMonths.append(self.nowCalendarDate)
        
        for plusNum in 1...11 {
            let month = self.calendar.date(byAdding: .month, value: plusNum, to: nowCalendarDate)
            self.yearMonths.append(month ?? Date())
        }
    }
    
    func setMonthDays() {
        //self.monthDays.removeAll() // 기존 데이터 초기화
        self.yearMonths.forEach {
            let days = self.calendarFormatter.updateCurrentMonthDays(calendarDate: $0)
            self.monthDays.append(days)
        }
    }
}
