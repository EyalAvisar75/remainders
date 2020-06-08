//
//  CalendarVars.swift
//  RemaindersCalendar
//
//  Created by eyal avisar on 02/06/2020.
//  Copyright © 2020 eyal avisar. All rights reserved.
//

import Foundation

let date = Date()
let calendar = Calendar.current

let day = calendar.component(.day, from: date)
let weekday = calendar.component(.weekday, from: date)
let month = calendar.component(.month, from: date) - 1
let year = calendar.component(.year, from: date)
