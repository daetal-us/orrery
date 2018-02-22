//
//  sol.swift
//  Orrery
//

import Foundation

class Sol {
    var events: SolarEvents = SolarEvents()
    var position: HorizontalPosition = HorizontalPosition()
    
    init(_ observer: GeographicPosition, _ moment: Moment) {
        let phi = observer.latitude.radians
        let RA = Sol.rightAscension(moment)
        let H = Sol.siderealTime(observer, moment) - RA
        // compute and bind position to instance
        let dec = Sol.declination(moment)
        self.position.azimuth = Sol.azimuth(H, phi, dec).degrees
        self.position.altitude = Sol.altitude(H, phi, dec).degrees
        
        let ds = Sol.approximateTransit(0, observer, moment)
        let M = Sol.meanAnomaly(ds)
        let L = Sol.eclipticLongitude(M)
        let jn = Sol.solarTransit(ds, M, L)
        self.events.solarNoon = Moment(jn)
        self.events.nadir = Moment(jn - 0.5)
        
    }
    
    static func azimuth(_ H: Radians, _ phi: Radians, _ dec: Radians) -> Radians {
        return .pi + atan2(sin(H), cos(H) * sin(phi) - tan(dec) * cos(phi))
    }
    
    static func altitude(_ H: Radians, _ phi: Radians, _ dec: Radians) -> Radians {
        return asin(sin(phi) * sin(dec) + cos(phi) * cos(dec) * cos(H))
    }
    
    static func siderealTime(_ observer: GeographicPosition, _ moment: Moment) -> Radians {
        let rad = Double.pi / 180
        let lw = rad * -observer.longitude
        return rad * (280.16 + 360.9856235 * moment.JD) - lw;
    }
    
    static func declination(_ moment: Moment) -> Radians {
        let M = Sol.meanAnomaly(moment.JD)
        let l = Sol.eclipticLongitude(M)
        let b = 0.0
        let e = Terra.obliquity(moment.JC, M)
        return asin(sin(b) * cos(e) + cos(b) * sin(e) * sin(l))
    }
    
    static func rightAscension(_ moment: Moment) -> Radians {
        let M = Sol.meanAnomaly(moment.JD)
        let l = Sol.eclipticLongitude(M)
        let b = 0.0
        let e = Terra.obliquity(moment.JC, M)
        return atan2(sin(l) * cos(e) - tan(b) * sin(e), cos(l))
    }
    
    static func meanLongitude(_ moment: Moment) -> Degrees {
        let T = moment.JCR
        var L = 280.46645 + (36000.76983 * T) + (0.0003032 * pow(T, 2))
        L = L.truncatingRemainder(dividingBy: 360)
        return L < 0 ? L + 360 : L;
    }
    
    static func meanAnomaly(_ jd: JulianDate) -> Radians {
        return Degrees(357.5291 + 0.98560028 * jd).radians
    }
    
    static func eclipticLongitude(_ M: Radians) -> Radians {
        let C = Sol.equationOfCenter(M)
        return M + C + Terra.perihelion.radians + Double.pi;
    }
    
    static func equationOfCenter(_ M: Radians) -> Radians {
        return Degrees(1.9148 * sin(M) + 0.02 * sin(2 * M) + 0.0003 * sin(3 * M)).radians
    }
    
    static func julianCycle(_ observer: GeographicPosition, _ moment: Moment) -> Radians {
        let lw = -observer.longitude.radians
        return (moment.JD - 0.0009 - lw / (.pi * 2)).rounded()
    }
    
    static func approximateTransit(_ hourAngle: Radians, _ observer: GeographicPosition, _ moment: Moment) -> Radians {
        let n = Sol.julianCycle(observer, moment)
        let lw = -observer.longitude.radians
        return 0.0009 + (hourAngle + lw) / (.pi * 2) + n
    }
    
    static func solarTransit(_ daysFromJ2K: JulianDate, _ M: Radians, _ L: Radians) -> JulianDate {
        return J2K + daysFromJ2K + 0.0053 * sin(M) - 0.0069 * sin(2 * L);
    }
}

class SolarEvents {
    var rise: EventDuration?
    var set: EventDuration?
    var twilight: EventDuration?
    var goldenHour: EventDuration?
    var solarNoon: Moment?
    var nadir: Moment?
    var dusk: Moment?
    var dawn: Moment?
    var nauticalDusk: Moment?
    var nauticalDawn: Moment?
}
