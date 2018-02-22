//
//  moment.swift
//  Orrery
//

import Foundation

// Julian Epoch
let J2K: JulianDayNumber = 2451545

class Moment {
    var date: NSDate = NSDate()
    
    // Julian Date
    var JD: JulianDate {
        return 2440587.5 + (self.date.timeIntervalSince1970 / 86400) - J2K
    }
    
    // Julian Day Number
    var JDN: JulianDayNumber {
        return self.JD.JDN
    }
    
    // Julian Centuries reckoned from fractional JD
    var JC: JulianCentury {
        return self.JD.JC
    }
    
    // Julian Centuries reckoned from rounded JDN
    var JCR: JulianCentury {
        return self.JDN.JC
    }
    
    // Initial with an NSDate object
    init(_ date: NSDate) {
        self.date = date
    }
    
    // Initialized with a Julian Date
    init(_ date: JulianDate) {
        let seconds = (date - 2440587.5) * 86400
        self.date = NSDate(timeIntervalSince1970: seconds)
        
    }
}
