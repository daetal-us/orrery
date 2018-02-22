//
//  orrery.swift
//  Orrery
//

import Foundation

class Orrery {
    var observer: GeographicPosition?
    var moment: Moment?
    var terra: Terra?
    var sol: Sol?
    var luna: Luna?
    
    init(date: NSDate, latitude: Double, longitude: Double) {
        self.moment = Moment(date)
        self.observer = GeographicPosition(latitude, longitude)
        self.terra = Terra(self.observer!, self.moment!)
        self.sol = Sol(self.observer!, self.moment!)
        self.luna = Luna(self.observer!, self.moment!)
    }
}

class GeographicPosition {
    var latitude: Degrees = 0.0
    var longitude: Degrees = 0.0
    var altitude: Meters = 0.0
    
    init(_ latitude: Degrees, _ longitude: Degrees) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class HorizontalPosition {
    var altitude: Degrees = 0.0
    var azimuth: Degrees = 0.0
    var distance: Meters = 0.0
    var parallacticAngle: Degrees = 0.0
}

class EventDuration {
    var start: Moment?
    var end: Moment?
}

// Cosmetics for readability
typealias Meters = Double
typealias Kilometers = Double
typealias Radians = Double
typealias Degrees = Double
typealias JulianDate = Double
typealias JulianDayNumber = Double
typealias JulianCentury = Double

extension Double {
    var degrees: Degrees { return self * (180 / .pi) }
    var radians: Radians { return self * (.pi / 180) }
    var km: Kilometers { return self / 1000 }
    var m: Meters { return self * 1000 }
    var JDN: JulianDayNumber { return self.rounded(.towardZero) }
    var JC: JulianCentury { return self / 36525 }
}


