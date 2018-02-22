//
//  terra.swift
//  Orrery
//

import Foundation

class Terra {
    static let perihelion: Degrees = 102.9372
    
    var observer: GeographicPosition?
    var moment: Moment?
    
    // Calculate Earths Obliquity Nutation
    static func obliquity(_ T: Double, _ LS: Radians) -> Radians {
        let K = Double.pi / 180
        let LM = 218.3165 + (481267.8813 * T)
        let omega = 125.04452 - 1934.136261 * T + 0.0020708 * pow(T, 2) + pow(T, 3)/450000
        let eps = 23 + 26/60 + 21.448/3600 - (46.8150 * T + 0.00059 * pow(T, 2) - 0.001813 * pow(T, 3)) / 3600
        let delta = (9.20 * cos(K * omega) + 0.57 * cos(K * 2 * LS) + 0.10 * cos(K * 2 * LM) - 0.09 * cos(K * 2 * omega)) / 3600
        return Degrees(eps + delta).radians;
    }
    
    init(_ observer: GeographicPosition, _ moment: Moment) {
        self.observer = observer
        self.moment = moment
    }
    
}
