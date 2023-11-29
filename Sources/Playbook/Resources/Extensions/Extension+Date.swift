//
//  Extension+Date.swift
//
//
//  Created by Rachel Radford on 11/22/23.
//

import Foundation

extension Date {
  func makeDate(year: Int = 0, month: Int, day: Int, hr: Int = 0, min: Int = 0, sec: Int = 0) -> Date {
    let calendar = Calendar(identifier: .gregorian)
    let components = DateComponents(year: year, month: month, day: day, hour: hr, minute: min, second: sec)
    return calendar.date(from: components)!
  }
}
