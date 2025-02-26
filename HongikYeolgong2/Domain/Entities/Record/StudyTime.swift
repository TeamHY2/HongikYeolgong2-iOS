//
//  StudyTime.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/6/24.
//

import Foundation

struct StudyTime {
    let yearHours: Int
    let yearMinutes: Int
    let monthHours: Int
    let monthMinutes: Int
    let dayHours: Int
    let dayMinutes: Int
    let semesterHours: Int
    let semesterMinutes: Int
    
    init(yearHours: Int, yearMinutes: Int, monthHours: Int, monthMinutes: Int, dayHours: Int, dayMinutes: Int, semesterHours: Int, semesterMinutes: Int) {
        self.yearHours = yearHours
        self.yearMinutes = yearMinutes
        self.monthHours = monthHours
        self.monthMinutes = monthMinutes
        self.dayHours = dayHours
        self.dayMinutes = dayMinutes
        self.semesterHours = semesterHours
        self.semesterMinutes = semesterMinutes
    }
    
    init() {
        self.yearHours = 0
        self.yearMinutes = 0
        self.monthHours = 0
        self.monthMinutes = 0
        self.dayHours = 0
        self.dayMinutes = 0
        self.semesterHours = 0
        self.semesterMinutes = 0
    }
}
